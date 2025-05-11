import 'dart:developer';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_workout/database/dao.dart';
import 'package:runner_workout/database/schema.dart' as schema;
import 'package:runner_workout/database/schema.dart';
import '../utils/workout_calculator.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<schema.BlockData> _blocks = [];
  final List<schema.StepData> _steps = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveWorkout() async {
    if (_formKey.currentState!.validate()) {
      // Add name validation
      if (_nameController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a workout name'),
          ),
        );
        return;
      }

      log('Saving workout with ${_blocks.length} blocks and ${_steps.length} steps');
      final db = Provider.of<AppDatabase>(context, listen: false);
      final dao = WorkoutDao(db);

      // Save workout
      final workoutId = await dao.createWorkout(
        WorkoutCompanion.insert(
          name: _nameController.text,
          description: drift.Value(_descriptionController.text),
        ),
      );
      log('Created workout with ID: $workoutId');

      // Save blocks
      for (final block in _blocks) {
        log('Saving block: ${block.name} with ${_steps.where((s) => s.blockId == block.id).length} steps');
        final blockId = await dao.createBlock(
          BlockCompanion.insert(
            name: block.name,
            workoutId: workoutId,
            order: block.order,
            repeatCount: drift.Value(block.repeatCount),
          ),
        );
        log('Created block with ID: $blockId');

        // Save steps for each block
        final steps = _steps.where((s) => s.blockId == block.id).toList();
        for (final step in steps) {
          log('Saving step: ${step.name} (type: ${step.stepType})');
          await dao.createStep(
            StepCompanion.insert(
              name: step.name,
              stepType: step.stepType,
              blockId: blockId,
              order: step.order,
              durationSeconds: step.durationSeconds,
              targetSpeed: drift.Value(step.targetSpeed),
              targetDistance: drift.Value(step.targetDistance),
              orderIndex: step.orderIndex,
            ),
          );
        }
      }

      log('Workout saved successfully');
      // Navigate back
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveWorkout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _descriptionController.text,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16),
              Text('Total Duration: ${_calculateTotalWorkoutTime()}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Total Distance: ${_calculateTotalWorkoutDistance()}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: _blocks.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final block = _blocks[index];
                    return ExpansionTile(
                      title: Text(block.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeBlock(block),
                      ),
                      tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      collapsedBackgroundColor: Colors.blueGrey[50],
                      backgroundColor: Colors.blueGrey[100],
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: block.name,
                                decoration: const InputDecoration(
                                  labelText: 'Block Name',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _blocks[index] =
                                        block.copyWith(name: value);
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Text('Repeat '),
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (block.repeatCount > 1) {
                                          _blocks[index] = block.copyWith(
                                              repeatCount:
                                                  block.repeatCount - 1);
                                        }
                                      });
                                    },
                                  ),
                                  Text(block.repeatCount.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _blocks[index] = block.copyWith(
                                            repeatCount: block.repeatCount + 1);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text('Bloc Time: ${_calculateBlockTime(block)}'),
                              const SizedBox(height: 16),
                              Text(
                                  'Bloc Distance: ${WorkoutCalculator.calculateBlockDistance(block, _steps)}'),
                              const SizedBox(height: 16),
                              Text('Steps'),
                              ..._steps
                                  .where((s) => s.blockId == block.id)
                                  .map((step) {
                                return ListTile(
                                  title: Text(step.name),
                                  subtitle: Text('Type: ${step.stepType}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => _editStep(step),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => _removeStep(step),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => _addStep(block),
                                tooltip: 'Add Step',
                              ),
                              // ElevatedButton(
                              //   child: const Text('Add Step'),
                              //   onPressed: () => _addStep(block),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _addBlock,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addBlock() {
    setState(() {
      _blocks.add(schema.BlockData(
        workoutId: 1, // TODO: Get from the saved workout
        id: _blocks.length + 1,
        name: 'New Block ${_blocks.length + 1}',
        order: _blocks.length + 1,
        repeatCount: 1,
      ));
    });
  }

  void _addStep(schema.BlockData block) {
    setState(() {
      _steps.add(schema.StepData(
        id: _steps.length + 1,
        blockId: block.id,
        name: 'New Step ${_steps.length + 1}',
        stepType: 'time', // Default to time type
        order: _steps.length + 1,
        durationSeconds: 60,
        targetSpeed: 10.0,
        targetDistance: 100.0,
        orderIndex: _steps.length + 1,
      ));
    });
  }

  void _editStep(schema.StepData step) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Step'),
          content: StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: step.name,
                  decoration: const InputDecoration(labelText: 'Step Name'),
                  onChanged: (value) {
                    setState(() {
                      step = step.copyWith(name: value);
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: step.stepType,
                  items: const [
                    DropdownMenuItem(
                        value: 'time', child: Text('Time and Speed')),
                    DropdownMenuItem(
                        value: 'distance', child: Text('Distance and Speed')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      step = step.copyWith(stepType: value);
                      log(step.stepType.toString());
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Step Type'),
                ),
                const SizedBox(height: 16),
                if (step.stepType == 'time')
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue:
                                  (step.durationSeconds ~/ 3600).toString(),
                              decoration:
                                  const InputDecoration(labelText: 'Hours'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                final hours = int.tryParse(value) ?? 0;
                                final minutes =
                                    (step.durationSeconds % 3600) ~/ 60;
                                final seconds = step.durationSeconds % 60;
                                setState(() {
                                  step = step.copyWith(
                                    durationSeconds:
                                        hours * 3600 + minutes * 60 + seconds,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              initialValue:
                                  ((step.durationSeconds % 3600) ~/ 60)
                                      .toString(),
                              decoration:
                                  const InputDecoration(labelText: 'Minutes'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                final hours = step.durationSeconds ~/ 3600;
                                final minutes = int.tryParse(value) ?? 0;
                                final seconds = step.durationSeconds % 60;
                                setState(() {
                                  step = step.copyWith(
                                    durationSeconds:
                                        hours * 3600 + minutes * 60 + seconds,
                                  );
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              initialValue:
                                  (step.durationSeconds % 60).toString(),
                              decoration:
                                  const InputDecoration(labelText: 'Seconds'),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                final hours = step.durationSeconds ~/ 3600;
                                final minutes =
                                    (step.durationSeconds % 3600) ~/ 60;
                                final seconds = int.tryParse(value) ?? 0;
                                setState(() {
                                  step = step.copyWith(
                                    durationSeconds:
                                        hours * 3600 + minutes * 60 + seconds,
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                if (step.stepType == 'distance')
                  TextFormField(
                    initialValue: step.targetDistance.toString(),
                    decoration:
                        const InputDecoration(labelText: 'Target Distance (m)'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        step = step.copyWith(
                            targetDistance: drift.Value(double.parse(value)));
                      });
                    },
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _getSpeedMinutes(step.targetSpeed ?? 0.0)
                            .toString(),
                        decoration:
                            const InputDecoration(labelText: 'Speed Minutes'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final minutes = int.tryParse(value) ?? 0;
                          final seconds =
                              _getSpeedSeconds(step.targetSpeed ?? 0.0);
                          setState(() {
                            step = step.copyWith(
                                targetSpeed: drift.Value(
                                    _calculateSpeed(minutes, seconds)));
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: _getSpeedSeconds(step.targetSpeed ?? 0.0)
                            .toString(),
                        decoration:
                            const InputDecoration(labelText: 'Speed Seconds'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final minutes =
                              _getSpeedMinutes(step.targetSpeed ?? 0.0);
                          final seconds = int.tryParse(value) ?? 0;
                          setState(() {
                            step = step.copyWith(
                                targetSpeed: drift.Value(
                                    _calculateSpeed(minutes, seconds)));
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  _steps[_steps.indexWhere((s) => s.id == step.id)] = step;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeBlock(schema.BlockData block) {
    setState(() {
      _blocks.remove(block);
      _steps.removeWhere((step) => step.blockId == block.id);
    });
  }

  void _removeStep(schema.StepData step) {
    setState(() {
      _steps.remove(step);
    });
  }

  String _calculateBlockTime(schema.BlockData block) {
    final steps = _steps.where((s) => s.blockId == block.id);
    final totalSeconds = steps.fold(0, (sum, step) {
          if (step.stepType == 'time') {
            return sum + step.durationSeconds;
          } else if (step.stepType == 'distance') {
            // Calculate time based on distance and speed
            final speed = step.targetSpeed!; // in km/h
            final distance = step.targetDistance!; // in meters
            if (speed > 0 && distance > 0) {
              final timeSeconds = (distance / 1000) / speed * 3600;
              return sum + timeSeconds.round();
            }
          }
          return sum;
        }) *
        block.repeatCount;

    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _calculateTotalWorkoutTime() {
    return WorkoutCalculator.calculateTotalTime(_blocks, _steps);
  }

  String _calculateTotalWorkoutDistance() {
    return WorkoutCalculator.calculateTotalDistance(_blocks, _steps);
  }

  int _getSpeedMinutes(double speed) {
    if (speed == 0) return 0;
    final pace = 60 / speed;
    return pace.floor();
  }

  int _getSpeedSeconds(double speed) {
    if (speed == 0) return 0;
    final pace = 60 / speed;
    return ((pace - pace.floor()) * 60).round();
  }

  double _calculateSpeed(int minutes, int seconds) {
    final totalSeconds = minutes * 60 + seconds;
    return totalSeconds > 0 ? 3600 / totalSeconds : 0.0;
  }

  String _formatSpeed(double speed) {
    if (speed == 0) return '0:00';
    final pace = 60 / speed; // Convert km/h to min/km
    final minutes = pace.floor();
    final seconds = ((pace - minutes) * 60).round();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  double _parseSpeed(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return 0.0;
    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;
    final totalSeconds = minutes * 60 + seconds;
    return totalSeconds > 0
        ? 3600 / totalSeconds
        : 0.0; // Convert min/km to km/h
  }
}
