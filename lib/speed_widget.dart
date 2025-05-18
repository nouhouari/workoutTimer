import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:runner_workout/playable.dart';
import 'package:runner_workout/utils/format_util.dart';

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

class SpeedWidget extends StatefulWidget {
  final double targetSpeed; // Add this line

  const SpeedWidget({super.key, required this.targetSpeed}); // Modify this line

  @override
  State<SpeedWidget> createState() => _SpeedWidgetState();
}

class _SpeedWidgetState extends State<SpeedWidget> implements Playable {
  double _currentSpeed = 0.0;
  double _distance = 0.0;
  Position? _lastPosition;
  StreamSubscription<Position>? _positionStream;
  bool _gpsAcquired = false;
  bool _isPaused = false;
  bool _isStopped = true;

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
      _distance = 0.0;
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
    _startListening();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<bool> _handlePermission() async {
    LocationPermission permission;
    // Test if location services are enabled.
    bool serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  Future<void> _startListening() async {
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      // timeLimit: Duration(seconds: 1),
      // distanceFilter: 1, // Update every 1 meter
    );

    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        _gpsAcquired = true; // Add this line
        if (_lastPosition != null) {
          _distance += Geolocator.distanceBetween(
            _lastPosition!.latitude,
            _lastPosition!.longitude,
            position.latitude,
            position.longitude,
          );
        }
        _currentSpeed = position.speed;
        if (_currentSpeed < 1) {
          _currentSpeed = 0;
        }
        _lastPosition = position;
      });
    });
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
              const SizedBox(width: 8),
              Text(
                _gpsAcquired ? 'GPS Acquired' : 'Acquiring GPS...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Current Speed',
          ),
          Text(
            FormatUtil.formatSpeed(_currentSpeed),
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
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.run_circle,
                size: 32,
                color: _getIconColor(0),
              ),
              Icon(
                Icons.run_circle,
                size: 32,
                color: _getIconColor(1),
              ),
              Icon(
                Icons.run_circle,
                size: 32,
                color: _getIconColor(2),
              ),
              Icon(
                Icons.run_circle,
                size: 32,
                color: _getIconColor(3),
              ),
              Icon(
                Icons.run_circle,
                size: 32,
                color: _getIconColor(4),
              ),
            ],
          ),
          Text(
            'Distance',
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

  Color? _getIconColor(int index) {
    // Convert speeds to min/km
    final currentPace = _currentSpeed > 0 ? 1000 / _currentSpeed : 0;
    final targetPace = widget.targetSpeed > 0 ? 1000 / widget.targetSpeed : 0;
    final paceDifference = currentPace - targetPace;

    if (paceDifference >= -5 && paceDifference <= 5) {
      return index == 2 ? Colors.green : Colors.grey;
    } else if (paceDifference > 5 && paceDifference <= 10) {
      return index == 3 ? Colors.red[200] : Colors.grey;
    } else if (paceDifference > 10) {
      return index == 4 ? Colors.red[400] : Colors.grey;
    } else if (paceDifference < -5 && paceDifference >= -10) {
      return index == 1 ? Colors.blue[200] : Colors.grey;
    } else if (paceDifference < -10) {
      return index == 0 ? Colors.blue : Colors.grey;
    }
    return Colors.grey;
  }
}
