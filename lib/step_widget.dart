import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:runner_workout/playable.dart';

class StepWidget extends StatefulWidget {
  const StepWidget({super.key});

  @override
  State<StepWidget> createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> implements Playable {
  int _stepsPerMinute = 0;
  int _totalSteps = 0;
  DateTime? _lastUpdate;
  StreamSubscription<StepCount>? _stepStream;
  bool _isPaused = false;
  bool _isStopped = true;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await Permission.activityRecognition.request();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @override
  void start() {
    if (!_isStopped) return;
    setState(() {
      _isStopped = false;
      _isPaused = false;
      _stepsPerMinute = 0;
      _totalSteps = 0;
      _startListening();
    });
  }

  @override
  void stop() {
    _stepStream?.cancel();
    setState(() {
      _isStopped = true;
      _isPaused = false;
      _stepsPerMinute = 0;
      _totalSteps = 0;
    });
  }

  @override
  void pause() {
    if (_isStopped || _isPaused) return;
    _stepStream?.cancel();
    setState(() {
      _isPaused = true;
    });
  }

  @override
  void resume() {
    if (!_isPaused) return;
    setState(() {
      _isPaused = false;
      _startListening();
    });
  }

  @override
  bool isPaused() => _isPaused;

  @override
  bool isStopped() => _isStopped;

  void _startListening() {
    _stepStream = Pedometer.stepCountStream.listen((StepCount event) {
      final now = DateTime.now();
      setState(() {
        if (_lastUpdate != null) {
          final minutes = now.difference(_lastUpdate!).inMinutes;
          if (minutes > 0) {
            _stepsPerMinute = (event.steps - _totalSteps) ~/ minutes;
          }
        }
        _totalSteps = event.steps;
        _lastUpdate = now;
      });
    }, onError: (error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Steps per Minute: ${_isStopped || _isPaused ? 'N/A' : _stepsPerMinute}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Total Steps: ${_isStopped || _isPaused ? 'N/A' : _totalSteps}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
