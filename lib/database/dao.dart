import 'package:drift/drift.dart';
import 'schema.dart';

part 'dao.g.dart';

@DriftAccessor(tables: [Workout, Block, Step])
class WorkoutDao extends DatabaseAccessor<AppDatabase> with _$WorkoutDaoMixin {
  WorkoutDao(AppDatabase db) : super(db);

  // Workout CRUD
  Future<int> createWorkout(WorkoutCompanion companion) =>
      into(workout).insert(companion);

  Future<List<WorkoutData>> getAllWorkouts() => select(workout).get();

  Future<WorkoutData?> getWorkout(int id) =>
      (select(workout)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<bool> updateWorkout(WorkoutData data) => update(workout).replace(data);

  Future<int> deleteWorkout(int id) =>
      (delete(workout)..where((t) => t.id.equals(id))).go();

  // Block CRUD
  Future<int> createBlock(BlockCompanion companion) =>
      into(block).insert(companion);

  Future<bool> updateBlock(BlockData data) => update(block).replace(data);

  Future<List<BlockData>> getBlocksByWorkoutId(int workoutId) => (select(block)
        ..where((b) => b.workoutId.equals(workoutId))
        ..orderBy([(b) => OrderingTerm(expression: b.order)]))
      .get();

  Future<List<StepData>> getStepsByWorkoutId(int workoutId) async {
    final blocks = await getBlocksByWorkoutId(workoutId);
    final blockIds = blocks.map((b) => b.id).toList();
    return (select(step)
          ..where((s) => s.blockId.isIn(blockIds))
          ..orderBy([(s) => OrderingTerm(expression: s.order)]))
        .get();
  }

  Future<int> updateBlockOrder(int blockId, int newOrder) =>
      (update(block)..where((b) => b.id.equals(blockId)))
          .write(BlockCompanion(order: Value(newOrder)));

  Future<void> deleteBlock(int blockId) async {
    // First delete all steps associated with this block
    await (delete(step)..where((t) => t.blockId.equals(blockId))).go();
    // Then delete the block itself
    await (delete(block)..where((t) => t.id.equals(blockId))).go();
  }

  // Step CRUD
  Future<int> createStep(StepCompanion companion) =>
      into(step).insert(companion);

  Future<bool> updateStep(StepData data) => update(step).replace(data);

  Future<List<StepData>> getStepsForBlock(int blockId) => (select(step)
        ..where((s) => s.blockId.equals(blockId))
        ..orderBy([(s) => OrderingTerm(expression: s.order)]))
      .get();

  Future<int> updateStepOrder(int stepId, int newOrder) =>
      (update(step)..where((s) => s.id.equals(stepId)))
          .write(StepCompanion(order: Value(newOrder)));

  Future<int> deleteStep(int id) =>
      (delete(step)..where((s) => s.id.equals(id))).go();

  // Workout Cloning
  Future<int> cloneWorkout(int workoutId) async {
    // Get the original workout
    final original = await getWorkout(workoutId);
    if (original == null) throw Exception('Workout not found');

    // Create new workout
    final newWorkoutId = await createWorkout(WorkoutCompanion.insert(
      name: '${original.name} (Copy)',
      description: Value(original.description),
      createdAt: Value(DateTime.now()),
    ));

    // Get and clone blocks
    final blocks = await getBlocksByWorkoutId(workoutId);
    for (final block in blocks) {
      final newBlockId = await createBlock(BlockCompanion.insert(
        name: block.name,
        workoutId: newWorkoutId,
        order: block.order,
        repeatCount: Value(block.repeatCount),
      ));

      // Get and clone steps
      final steps = await getStepsForBlock(block.id);
      for (final step in steps) {
        await createStep(StepCompanion.insert(
          name: step.name,
          stepType: step.stepType,
          blockId: newBlockId,
          order: step.order,
          durationSeconds: step.durationSeconds,
          targetSpeed: Value(step.targetSpeed),
          targetDistance: Value(step.targetDistance),
          orderIndex: step.orderIndex,
        ));
      }
    }

    return newWorkoutId;
  }

  // Bulk operations
  Future<void> reorderBlocks(List<int> newOrder) async {
    for (var i = 0; i < newOrder.length; i++) {
      await updateBlockOrder(newOrder[i], i);
    }
  }

  Future<void> reorderSteps(List<int> newOrder) async {
    for (var i = 0; i < newOrder.length; i++) {
      await updateStepOrder(newOrder[i], i);
    }
  }
}
