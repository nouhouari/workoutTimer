import 'package:runner_workout/database/schema.dart';

class WorkoutCalculator {
  static String calculateBlockTime(BlockData block, List<StepData> steps) {
    final blockSteps = steps.where((s) => s.blockId == block.id);
    var totalSeconds = blockSteps.fold(0, (sum, step) {
          if (step.stepType == 'time') {
            return sum + step.durationSeconds;
          } else if (step.stepType == 'distance') {
            final speed = step.targetSpeed!;
            final distance = step.targetDistance!;
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

  static String calculateBlockDistance(BlockData block, List<StepData> steps) {
    final blockSteps = steps.where((s) => s.blockId == block.id);
    var totalDistance = blockSteps.fold(0.0, (sum, step) {
          if (step.stepType == 'distance') {
            return sum + (step.targetDistance ?? 0);
          } else if (step.stepType == 'time') {
            final speed = step.targetSpeed!;
            final duration = step.durationSeconds;
            if (speed > 0 && duration > 0) {
              return sum + (speed / 3.6) * duration;
            }
          }
          return sum;
        }) *
        block.repeatCount;

    if (totalDistance >= 1000) {
      return '${(totalDistance / 1000).toStringAsFixed(1)}km';
    }
    return '${totalDistance.toStringAsFixed(0)}m';
  }

  static String calculateTotalTime(
      List<BlockData> blocks, List<StepData> steps) {
    var totalSeconds = 0;
    for (final block in blocks) {
      totalSeconds += _calculateBlockSeconds(block, steps);
    }
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  static String calculateTotalDistance(
      List<BlockData> blocks, List<StepData> steps) {
    var totalDistance = 0.0;
    for (final block in blocks) {
      totalDistance += _calculateBlockMeters(block, steps);
    }
    if (totalDistance >= 1000) {
      return '${(totalDistance / 1000).toStringAsFixed(1)}km';
    }
    return '${totalDistance.toStringAsFixed(0)}m';
  }

  static int _calculateBlockSeconds(BlockData block, List<StepData> steps) {
    final blockSteps = steps.where((s) => s.blockId == block.id);
    return blockSteps.fold(0, (sum, step) {
          if (step.stepType == 'time') {
            return sum + step.durationSeconds;
          } else if (step.stepType == 'distance') {
            final speed = step.targetSpeed!;
            final distance = step.targetDistance!;
            if (speed > 0 && distance > 0) {
              return sum + ((distance / 1000) / speed * 3600).round();
            }
          }
          return sum;
        }) *
        block.repeatCount;
  }

  static double _calculateBlockMeters(BlockData block, List<StepData> steps) {
    final blockSteps = steps.where((s) => s.blockId == block.id);
    return blockSteps.fold(0.0, (sum, step) {
          if (step.stepType == 'distance') {
            return sum + (step.targetDistance ?? 0);
          } else if (step.stepType == 'time') {
            final speed = step.targetSpeed!;
            final duration = step.durationSeconds;
            if (speed > 0 && duration > 0) {
              return sum + (speed / 3.6) * duration;
            }
          }
          return sum;
        }) *
        block.repeatCount;
  }
}
