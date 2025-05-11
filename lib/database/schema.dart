import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'schema.g.dart';

class Workout extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class Block extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get workoutId => integer().references(Workout, #id)();
  IntColumn get order => integer()();
  IntColumn get repeatCount => integer().withDefault(const Constant(1))();
}

class Step extends Table {
  IntColumn get id => integer().autoIncrement()();
  // Descriptive name
  TextColumn get name => text().withLength(min: 1, max: 50)();
  // Step type: 'time', 'distance', or 'free'
  TextColumn get stepType => text().withLength(min: 4, max: 8)();
  IntColumn get blockId => integer().references(Block, #id)();
  IntColumn get order => integer()();
  IntColumn get durationSeconds => integer()();
  RealColumn get targetSpeed => real().nullable()();
  RealColumn get targetDistance => real().nullable()();
  IntColumn get orderIndex => integer()(); // For sorting within block
}

class WorkoutHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutId => integer().references(Workout, #id)();
  DateTimeColumn get completedAt =>
      dateTime().withDefault(currentDateAndTime)();
  RealColumn get distance => real().nullable()(); // meters
  IntColumn get duration => integer().nullable()(); // seconds
}

class IntervalHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get workoutHistoryId => integer().references(WorkoutHistory, #id)();
  IntColumn get stepId => integer().references(Step, #id).nullable()();
  TextColumn get stepName => text()();
  IntColumn get targetDuration => integer().nullable()(); // seconds
  IntColumn get actualDuration => integer().nullable()(); // seconds
  IntColumn get targetDistance => integer().nullable()(); // meters
  IntColumn get actualDistance => integer().nullable()(); // meters
  IntColumn get targetPace => integer().nullable()(); // sec/km
  IntColumn get actualPace => integer().nullable()(); // sec/km
  IntColumn get orderIndex => integer()(); // Original position in workout
}

@DriftDatabase(tables: [Workout, Block, Step, WorkoutHistory, IntervalHistory])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
