import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_workout/database/dao.dart';
import 'package:runner_workout/database/schema.dart';
import '../utils/workout_calculator.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutData workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late AppDatabase _database;
  late WorkoutDao _workoutDao;
  List<BlockData> _blocks = [];
  List<StepData> _steps = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = Provider.of<AppDatabase>(context, listen: false);
    _workoutDao = WorkoutDao(_database);
    _loadWorkoutDetails();
  }

  Future<void> _loadWorkoutDetails() async {
    final blocks = await _workoutDao.getBlocksByWorkoutId(widget.workout.id);
    final steps = await _workoutDao.getStepsByWorkoutId(widget.workout.id);
    setState(() {
      _blocks = blocks;
      _steps = steps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'workout-${widget.workout.id}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.workout.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Add this line
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.workout.description != null &&
                  widget.workout.description!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.workout.description ?? 'No description',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.blueGrey[800],
                        ),
                  ),
                ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      // Changed from Expanded
                      child: _buildDetailCard(
                        Icons.timer,
                        'Total Time',
                        WorkoutCalculator.calculateTotalTime(_blocks, _steps),
                      ),
                    ),
                    Flexible(
                      // Changed from Expanded
                      child: _buildDetailCard(
                        Icons.directions_run,
                        'Distance',
                        WorkoutCalculator.calculateTotalDistance(
                            _blocks, _steps),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
                // Wrap the ListView in a Column with MainAxisSize.min
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.separated(
                    shrinkWrap: true, // Add this line
                    physics: NeverScrollableScrollPhysics(), // Add this line
                    itemCount: _blocks.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final block = _blocks[index];
                      final blockSteps =
                          _steps.where((s) => s.blockId == block.id).toList();
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (block.repeatCount > 1)
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${block.repeatCount}x',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey[800],
                                          ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 8),
                              Text(
                                block.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.timer, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Time: ${WorkoutCalculator.calculateBlockTime(block, _steps)}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.directions_run, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Distance: ${WorkoutCalculator.calculateBlockDistance(block, _steps)}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ...blockSteps.map((step) => ListTile(
                                    title: Text(step.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (step.stepType == 'time')
                                          Row(
                                            children: [
                                              Icon(Icons.timer, size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                  'Duration: ${_formatDuration(step.durationSeconds)}'),
                                            ],
                                          ),
                                        if (step.stepType == 'distance')
                                          Row(
                                            children: [
                                              Icon(Icons.directions_run,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                  'Distance: ${step.targetDistance}m'),
                                            ],
                                          ),
                                        Row(
                                          children: [
                                            Icon(Icons.speed, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                                'Speed: ${_formatSpeed(step.targetSpeed)}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// Add this method
// Update the _formatSpeed method
  String _formatSpeed(double? speed) {
    if (speed == null || speed <= 0) return 'N/A';
    final secondsPerKm = 3600 / speed;
    final minutes = secondsPerKm ~/ 60;
    final seconds = (secondsPerKm % 60).round();
    return '$minutes:${seconds.toString().padLeft(2, '0')}/km';
  }

// Add this method
  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildDetailCard(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.blueGrey),
        const SizedBox(height: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.blueGrey,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
