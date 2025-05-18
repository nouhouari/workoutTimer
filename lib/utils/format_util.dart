class FormatUtil {
  // Update the _formatSpeed method
  static String formatSpeed(double? speed) {
    if (speed == null || speed <= 0) return 'N/A';
    final secondsPerKm = 3600 / speed;
    final minutes = secondsPerKm ~/ 60;
    final seconds = (secondsPerKm % 60).round();
    return '$minutes:${seconds.toString().padLeft(2, '0')}/km';
  }

  static String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  // Update the _formatSpeed method
  static String formatSpeedForSpeech(double? speed) {
    if (speed == null || speed <= 0) return 'N/A';
    final secondsPerKm = 3600 / speed;
    final minutes = secondsPerKm ~/ 60;
    final seconds = (secondsPerKm % 60).round();
    String minutesString = '';
    String secondsString = '';
    if (minutes > 0) {
      minutesString = '$minutes minutes';
    }
    if (seconds > 0) {
      secondsString = '$seconds seconds';
    }
    return '$minutesString $secondsString per kilometer';
  }

  static String formatDurationForSpeech(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    String hoursString = '';
    String minutesString = '';
    String secondsString = '';
    if (hours > 0) {
      hoursString = '$hours hours';
    }
    if (minutes > 0) {
      minutesString = '$minutes minutes';
    }
    if (secs > 0) {
      secondsString = '$secs seconds';
    }
    return hoursString + minutesString + secondsString;
  }

  static String formatDistance(double distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(0)} m';
    }
    return '${(distance / 1000).toStringAsFixed(2)} km';
  }
}
