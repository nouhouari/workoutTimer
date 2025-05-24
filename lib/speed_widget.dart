import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:runner_workout/playable.dart';
import 'package:runner_workout/utils/format_util.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

class SpeedWidget extends StatefulWidget {
  final double targetSpeed;

  const SpeedWidget({super.key, required this.targetSpeed});

  @override
  State<SpeedWidget> createState() => _SpeedWidgetState();
}

class _SpeedWidgetState extends State<SpeedWidget> implements Playable {
  double _currentSpeed = 0.0;
  double _averageSpeed = 0.0; // Added for average speed
  double _distance = 0.0;
  Position? _lastPosition;
  StreamSubscription<Position>? _positionStream;
  bool _gpsAcquired = false;
  bool _isPaused = false;
  bool _isStopped = true;

  // Queue to store the last 10 seconds of speed readings
  final Queue<SpeedReading> _speedReadings = Queue<SpeedReading>();
  // How many seconds of history to keep
  final int _averagingPeriod = 10;

  @override
  void start() {
    if (!_isStopped) return;
    setState(() {
      _isStopped = false;
      _isPaused = false;
      _startListening();
    });
  }

  @override
  void stop() {
    _positionStream?.cancel();
    setState(() {
      _isStopped = true;
      _isPaused = false;
      _currentSpeed = 0.0;
      _averageSpeed = 0.0; // Reset average speed
      _distance = 0.0;
      _speedReadings.clear(); // Clear speed history
    });
  }

  @override
  void pause() {
    if (_isStopped || _isPaused) return;
    _positionStream?.cancel();
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

  @override
  void initState() {
    super.initState();
    // Don't automatically start listening - check permissions first
    _checkAndStartListening();
  }

  Future<void> _checkAndStartListening() async {
    final hasPermission = await _handlePermission();
    if (hasPermission && mounted) {
      _startListening();
    } else if (mounted) {
      // Show a message that GPS features won't work
      setState(() {
        _gpsAcquired = false;
      });
    }
  }

  Future<bool> _handlePermission() async {
    try {
      LocationPermission permission;
      // Test if location services are enabled.
      bool serviceEnabled =
          await _geolocatorPlatform.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        return false;
      }

      permission = await _geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _geolocatorPlatform.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      return true;
    } catch (e) {
      // Handle any exceptions that might occur
      print('Error checking location permission: $e');
      return false;
    }
  }

  Future<void> _startListening() async {
    try {
      final locationSettings = LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        // timeLimit: Duration(seconds: 1),
        // distanceFilter: 1, // Update every 1 meter
      );

      _positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(
        (Position position) {
          if (mounted) {
            setState(() {
              _gpsAcquired = true;
              if (_lastPosition != null) {
                _distance += Geolocator.distanceBetween(
                  _lastPosition!.latitude,
                  _lastPosition!.longitude,
                  position.latitude,
                  position.longitude,
                );
              }
              // convert position.speed from m/s to km/h
              _currentSpeed = position.speed * 3.6;
              if (_currentSpeed < 0) {
                _currentSpeed = 0;
              }

              // Add current speed to history with timestamp
              _addSpeedReading(_currentSpeed);

              // Calculate average speed
              _calculateAverageSpeed();

              _lastPosition = position;
            });
          }
        },
        onError: (error) {
          // Handle stream errors gracefully
          print('Location stream error: $error');
          if (mounted) {
            setState(() {
              _gpsAcquired = false;
            });

            // Attempt to recreate the stream after a delay
            // but only for certain types of errors
            if (error
                    .toString()
                    .contains('Location services are not enabled') ||
                error.toString().contains('Permission denied')) {
              // For permission or service errors, wait longer before retry
              Future.delayed(const Duration(seconds: 10), () {
                if (mounted && !_isPaused && !_isStopped) {
                  _checkAndStartListening();
                }
              });
            } else {
              // For other errors (like temporary GPS signal loss), retry sooner
              Future.delayed(const Duration(seconds: 3), () {
                if (mounted && !_isPaused && !_isStopped) {
                  _startListening();
                }
              });
            }
          }
        },
      );
    } catch (e) {
      // Handle any exceptions that might occur when starting the stream
      print('Error starting location stream: $e');
      if (mounted) {
        setState(() {
          _gpsAcquired = false;
        });

        // Attempt to recreate the stream after a delay
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted && !_isPaused && !_isStopped) {
            _checkAndStartListening();
          }
        });
      }
    }
  }

  // Add a new speed reading to the queue
  void _addSpeedReading(double speed) {
    final now = DateTime.now();
    _speedReadings.add(SpeedReading(speed: speed, timestamp: now));

    // Remove readings older than _averagingPeriod seconds
    while (_speedReadings.isNotEmpty &&
        now.difference(_speedReadings.first.timestamp).inSeconds >
            _averagingPeriod) {
      _speedReadings.removeFirst();
    }
  }

  // Calculate the average speed from the readings in the queue
  void _calculateAverageSpeed() {
    if (_speedReadings.isEmpty) {
      _averageSpeed = 0.0;
      return;
    }

    double sum = 0.0;
    for (var reading in _speedReadings) {
      sum += reading.speed;
    }

    _averageSpeed = sum / _speedReadings.length;
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontWeight: FontWeight.bold, fontSize: 32);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.gps_fixed,
                color: _gpsAcquired ? Colors.green : Colors.grey,
              ),
              // const SizedBox(width: 8),
              // Text(
              //   _gpsAcquired ? 'GPS Acquired' : 'Acquiring GPS...',
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Current Speed',
          ),
          Text(
            FormatUtil.formatSpeed(
                _averageSpeed), // Use average speed instead of current
            style: style,
          ),
          const SizedBox(height: 8),
          Text(
            'Target Speed',
          ),
          Text(
            FormatUtil.formatSpeed(widget.targetSpeed),
            style: style,
          ),
          const SizedBox(height: 10),
          // Replace icons with a speed indicator bar
          _buildSpeedIndicator(context),
          const SizedBox(height: 8),
          Text(
            'Current Distance',
            // style: style,
          ),
          Text(
            FormatUtil.formatDistance(_distance),
            style: style,
          ),
        ],
      ),
    );
  }

  // New method to build the speed indicator with cursor and color bar
  Widget _buildSpeedIndicator(BuildContext context) {
    final currentPace = _averageSpeed > 0 ? 3600 / _averageSpeed : 0;
    final targetPace = widget.targetSpeed > 0 ? 3600 / widget.targetSpeed : 0;
    final paceDifference = currentPace - targetPace;

    return SizedBox(
      width: 200,
      height: 200,
      child: SfRadialGauge(
        axes: [
          RadialAxis(
            minimum: -20,
            maximum: 20,
            ranges: [
              GaugeRange(
                startValue: -20,
                endValue: -10,
                color: Colors.blue,
                label: 'Very Slow',
              ),
              GaugeRange(
                startValue: -5,
                endValue: -10,
                color: Colors.blue[200],
                label: 'Slow',
              ),
              GaugeRange(
                startValue: -5,
                endValue: 5,
                color: Colors.green,
                label: 'Good',
              ),
              GaugeRange(
                startValue: 5,
                endValue: 10,
                color: Colors.red[200],
                label: 'Fast',
              ),
              GaugeRange(
                startValue: 10,
                endValue: 20,
                color: Colors.red,
                label: 'Very Fast',
              ),
            ],
            pointers: [
              NeedlePointer(
                value: paceDifference.clamp(-20, 20).toDouble(),
                needleColor: Colors.black54,
                needleLength: 0.8,
                knobStyle: KnobStyle(
                  knobRadius: 0.1,
                  color: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// Class to store speed readings with timestamps
class SpeedReading {
  final double speed;
  final DateTime timestamp;

  SpeedReading({required this.speed, required this.timestamp});
}
