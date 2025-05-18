import 'dart:io';

import 'package:flutter/material.dart';
import 'package:runner_workout/database/schema.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:runner_workout/speed_widget.dart';
// import 'package:runner_workout/step_widget.dart';
import 'package:runner_workout/utils/format_util.dart';
import 'package:runner_workout/utils/workout_calculator.dart';

class WorkoutExecutionScreen extends StatefulWidget {
  final WorkoutData workout;
  final List<BlockData> blocks;
  List<StepData> steps;

  WorkoutExecutionScreen({
    super.key,
    required this.workout,
    required this.blocks,
    required this.steps,
  });

  @override
  State<WorkoutExecutionScreen> createState() => _WorkoutExecutionScreenState();
}

class _WorkoutExecutionScreenState extends State<WorkoutExecutionScreen> {
  bool _isRunning = false;
  bool _isPaused = false;
  int _currentStepIndex = 0;
  int _currentBlockIndex = 0;
  int _remainingTime = 0;
  int _totalRemainingTime = 0;
  int _currentRepeatIndex = 0; // Add this line
  Timer? _timer;
  List<StepData> _currentSteps = [];
  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _calculateTotalRemainingTime();
    _currentSteps = widget.steps
        .where((step) => step.blockId == widget.blocks[_currentBlockIndex].id)
        .toList();
    _initAudio();
  }

  _initAudio() async {
    if (Platform.isIOS) {
      await tts.setSharedInstance(true);
    }
  }

  void _calculateTotalRemainingTime() {
    int total = 0;
    for (final block in widget.blocks) {
      final blockSteps = widget.steps.where((step) => step.blockId == block.id);
      final blockDuration =
          blockSteps.fold(0, (sum, step) => sum + _getStepDuration(step));
      total += blockDuration * block.repeatCount;
    }
    _totalRemainingTime = total;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _speak(_getStepAnnouncement(_currentSteps[_currentStepIndex]));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isRunning || _isPaused) return;

      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
          _totalRemainingTime--;
        } else {
          _moveToNextStep();
        }
      });
    });
  }

  void _moveToNextStep() {
    setState(() {
      // Get steps for current block
      var currentBlock = widget.blocks[_currentBlockIndex];
      _currentSteps = widget.steps
          .where((step) => step.blockId == currentBlock.id)
          .toList();

      if (_currentSteps.isEmpty) {
        _stopWorkout();
      }

      if (_currentStepIndex < _currentSteps.length - 1) {
        // Move to next step in current block
        _currentStepIndex++;
        _remainingTime = _getStepDuration(_currentSteps[_currentStepIndex]);
        _speak(_getStepAnnouncement(
            _currentSteps[_currentStepIndex])); // Modified this line
      } else {
        // Finished all steps in current block
        var remainingRepeats =
            currentBlock.repeatCount - _currentRepeatIndex - 1;
        if (remainingRepeats > 0) {
          // Repeat current block
          _currentRepeatIndex++;
          _currentStepIndex = 0;
          _remainingTime = _getStepDuration(_currentSteps[_currentStepIndex]);
          _speak(_getStepAnnouncement(
              _currentSteps[_currentStepIndex])); // Modified this line
        } else if (_currentBlockIndex < widget.blocks.length - 1) {
          // Move to next block
          _currentBlockIndex++;
          _currentStepIndex = 0;
          _currentRepeatIndex = 0;
          currentBlock = widget.blocks[_currentBlockIndex];
          remainingRepeats = currentBlock.repeatCount;
          _currentSteps = widget.steps
              .where((step) => step.blockId == currentBlock.id)
              .toList();
          _remainingTime = _getStepDuration(_currentSteps[_currentStepIndex]);
          _speak(_getStepAnnouncement(
              _currentSteps[_currentStepIndex])); // Modified this line
          if (_currentSteps.isEmpty) {
            _stopWorkout();
          }
        } else {
          // End of workout
          _stopWorkout();
        }
      }
    });
  }

  String _getStepAnnouncement(StepData step) {
    if (step.stepType == 'time') {
      return 'Run for ${FormatUtil.formatDurationForSpeech(step.durationSeconds)} at ${FormatUtil.formatSpeedForSpeech(step.targetSpeed)}';
    } else if (step.stepType == 'distance') {
      return 'Run ${step.targetDistance} at ${FormatUtil.formatSpeedForSpeech(step.targetSpeed)}';
    }
    return 'Starting step: ${step.name}';
  }

  int _getStepDuration(StepData step) {
    if (step.stepType == 'time') {
      return step.durationSeconds;
    } else if (step.stepType == 'distance') {
      final speed = step.targetSpeed ?? 0;
      if (speed > 0) {
        return ((step.targetDistance ?? 0) / (speed / 3.6)).round();
      }
    }
    return 0;
  }

  void _stopWorkout() {
    _speak("Workout completed");
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _timer?.cancel();
      _totalRemainingTime = _calculateTotalDuration();
      _remainingTime = _totalRemainingTime;
      _currentStepIndex = 0;
      // Reset total time
    });
  }

  int _calculateTotalDuration() {
    int total = 0;
    for (final block in widget.blocks) {
      final blockSteps = widget.steps.where((step) => step.blockId == block.id);
      final blockDuration =
          blockSteps.fold(0, (sum, step) => sum + _getStepDuration(step));
      total += blockDuration * block.repeatCount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontWeight: FontWeight.bold, fontSize: 32);
    var decoration = BoxDecoration(border: Border.all(color: Colors.grey));
    return WillPopScope(
      onWillPop: () async {
        if (_isRunning && !_isPaused) return false;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            if (_isPaused)
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: _stopWorkout,
                tooltip: 'Stop Workout',
              ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Executing ${widget.workout.name}'),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Time',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        FormatUtil.formatDuration(_totalRemainingTime),
                        style: style,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Total distance'),
                      Text(
                          WorkoutCalculator.calculateTotalDistance(
                              widget.blocks, widget.steps),
                          style: style),
                    ],
                  ),
                ),
              ],
            ),
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(
                        //   widget.blocks[_currentBlockIndex].name,
                        //   style:
                        //       Theme.of(context).textTheme.titleLarge?.copyWith(
                        //             color: Theme.of(context).primaryColor,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        // ),
                        Text(
                          '${_currentRepeatIndex + 1} /${widget.blocks[_currentBlockIndex].repeatCount}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Text(
                    //   _currentSteps[_currentStepIndex].name,
                    //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    //         color: Colors.orange,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: decoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Step Remaining Time',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Text(
                            FormatUtil.formatDuration(_remainingTime),
                            style: style,
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _getStepProgress(),
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_currentSteps[_currentStepIndex].stepType == 'time')
                      Row(
                        children: [
                          // Row(
                          //   children: [
                          //     Icon(Icons.timer, size: 16),
                          //     const SizedBox(width: 4),
                          //     Text(
                          //       'Duration: ${FormatUtil.formatDuration(_currentSteps[_currentStepIndex].durationSeconds)}',
                          //       style: Theme.of(context).textTheme.bodyMedium,
                          //     ),
                          //   ],
                          // ),
                          // Container(
                          //   decoration: decoration,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(10.0),
                          //     child: Column(children: [
                          //       Text('Duration'),
                          //       Text(
                          //         FormatUtil.formatDuration(
                          //             _currentSteps[_currentStepIndex]
                          //                 .durationSeconds),
                          //         style: style,
                          //       )
                          //     ]),
                          //   ),
                          // ),
                          // Container(
                          //   decoration: decoration,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(10.0),
                          //     child: Column(
                          //       children: [
                          //         Text(
                          //           'Target Speed',
                          //         ),
                          //         Text(
                          //           FormatUtil.formatSpeed(
                          //               _currentSteps[_currentStepIndex]
                          //                   .targetSpeed),
                          //           style: style,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    if (_currentSteps[_currentStepIndex].stepType == 'distance')
                      Row(
                        children: [
                          Icon(Icons.directions_run, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Distance: ${_currentSteps[_currentStepIndex].targetDistance}m',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpeedWidget(
                          targetSpeed:
                              _currentSteps[_currentStepIndex].targetSpeed ?? 0,
                        )
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Icon(Icons.speed, size: 16),
                    //     const SizedBox(width: 4),
                    //     Text(
                    //       'Speed: ${FormatUtil.formatSpeed(_currentSteps[_currentStepIndex].targetSpeed)}',
                    //       style: Theme.of(context).textTheme.bodyMedium,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            // if (_isRunning)
            // Column(
            //   children: [
            //     Card(
            //       margin: const EdgeInsets.all(16),
            //       child: Padding(
            //         padding: const EdgeInsets.all(16.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   widget.blocks[_currentBlockIndex].name,
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .titleLarge
            //                       ?.copyWith(
            //                         color: Theme.of(context).primaryColor,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                 ),
            //                 Text(
            //                     '${_currentRepeatIndex + 1} /${widget.blocks[_currentBlockIndex].repeatCount}'),
            //               ],
            //             ),

            //             const SizedBox(height: 8),
            //             Text(
            //               _currentSteps[_currentStepIndex].name,
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .titleLarge
            //                   ?.copyWith(
            //                     color: Colors.orange,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //             ),

            //             const SizedBox(height: 8),
            //             Row(
            //               children: [
            //                 Icon(Icons.timer, size: 16),
            //                 const SizedBox(width: 4),
            //                 Text(
            //                   'Step Remaining Time: ${FormatUtil.formatDuration(_remainingTime)}',
            //                   style: Theme.of(context).textTheme.bodyMedium,
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(height: 8),
            //             LinearProgressIndicator(
            //               value: _getStepProgress(),
            //               minHeight: 16, // Increased from 8
            //               backgroundColor: Colors.grey[200],
            //               valueColor: AlwaysStoppedAnimation<Color>(
            //                 Theme.of(context).primaryColor,
            //               ),
            //             ),
            //             const SizedBox(height: 24), // Increased from 16
            //             if (_currentSteps[_currentStepIndex].stepType ==
            //                 'time')
            //               Row(
            //                 children: [
            //                   Icon(Icons.timer, size: 16),
            //                   const SizedBox(width: 4),
            //                   Text(
            //                     'Duration: ${FormatUtil.formatDuration(_currentSteps[_currentStepIndex].durationSeconds)}',
            //                     style: Theme.of(context).textTheme.bodyMedium,
            //                   ),
            //                 ],
            //               ),
            //             if (_currentSteps[_currentStepIndex].stepType ==
            //                 'distance')
            //               Row(
            //                 children: [
            //                   Icon(Icons.directions_run, size: 16),
            //                   const SizedBox(width: 4),
            //                   Text(
            //                     'Distance: ${_currentSteps[_currentStepIndex].targetDistance}m',
            //                     style: Theme.of(context).textTheme.bodyMedium,
            //                   ),
            //                 ],
            //               ),
            //             Row(
            //               children: [
            //                 Icon(Icons.speed, size: 16),
            //                 const SizedBox(width: 4),
            //                 Text(
            //                   'Speed: ${FormatUtil.formatSpeed(_currentSteps[_currentStepIndex].targetSpeed)}',
            //                   style: Theme.of(context).textTheme.bodyMedium,
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     if (!_isRunning)
            //       Expanded(
            //         child: ListView.builder(
            //           itemCount: widget.blocks.length,
            //           itemBuilder: (context, index) {
            //             final block = widget.blocks[index];
            //             return Card(
            //               child: ExpansionTile(
            //                 title: Text(block.name),
            //                 children: widget.steps
            //                     .where((step) => step.blockId == block.id)
            //                     .map((step) => ListTile(
            //                           title: Text(step.name),
            //                           subtitle: Text(
            //                             step.stepType == 'time'
            //                                 ? 'Duration: ${FormatUtil.formatDuration(step.durationSeconds)}'
            //                                 : 'Distance: ${step.targetDistance}m',
            //                           ),
            //                         ))
            //                     .toList(),
            //               ),
            //             );
            //           },
            //         ),
            //       ),
            //   ],
            // ),
            // Container(
            //   decoration: decoration,
            //   child: const SpeedWidget(),
            // ),
            // const StepWidget(),
          ]),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (!_isRunning) {
                    // Start workout
                    _isRunning = true;
                    _isPaused = false;
                    _currentStepIndex = 0;
                    _currentBlockIndex = 0;
                    _currentRepeatIndex =
                        0; // Initialize with block's repeat count
                    _remainingTime =
                        _getStepDuration(_currentSteps[_currentStepIndex]);
                    _totalRemainingTime = _calculateTotalDuration();
                    _speak("Starting workout");
                    _startTimer();
                  } else if (_isRunning && !_isPaused) {
                    // Pause workout
                    _isPaused = true;
                    _speak("Pausing workout");
                  } else {
                    // Resume workout
                    _isPaused = false;
                    _speak("Resuming workout");
                  }
                });
              },
              backgroundColor: !_isRunning
                  ? Colors.blue
                  : (_isPaused ? Colors.orange : Colors.red),
              child: Icon(
                !_isRunning
                    ? Icons.play_arrow
                    : (_isPaused ? Icons.play_arrow : Icons.pause),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getStepProgress() {
    final totalDuration = _getStepDuration(_currentSteps[_currentStepIndex]);
    if (totalDuration == 0) return 0.0;
    return 1.0 - (_remainingTime / totalDuration);
  }

  Future<void> _speak(String message) async {
    await tts.setLanguage("en_US");
    await tts.speak(message);
  }
}
