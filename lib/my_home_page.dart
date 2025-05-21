import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_workout/add_workout.dart';
import 'package:runner_workout/database/dao.dart';
import 'package:runner_workout/database/schema.dart';
import 'package:runner_workout/workout_detail.dart';
import '../utils/workout_calculator.dart';
import 'package:drift/drift.dart' as drift;

class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  // Add refresh indicator key
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late AppDatabase _database;
  late WorkoutDao _workoutDao;
  List<WorkoutData> _workouts = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _database = Provider.of<AppDatabase>(context, listen: false);
    _workoutDao = WorkoutDao(_database);
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final workouts = await _workoutDao.getAllWorkouts();
    setState(() {
      _workouts = workouts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: _workouts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.directions_run,
                      size: 64, color: Colors.blueGrey),
                  const SizedBox(height: 24),
                  Text(
                    'No Workouts Yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Start your fitness journey by creating your first workout plan',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blueGrey[600],
                          ),
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _loadWorkouts,
              child: ListView.builder(
                itemCount: _workouts.length,
                itemBuilder: (context, index) {
                  final workout = _workouts[index];
                  return Dismissible(
                    key: Key(workout.id.toString()),
                    direction: DismissDirection.horizontal,
                    background: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      final removedWorkout = _workouts[index];
                      final dao = _workoutDao;
                      
                      if (direction == DismissDirection.endToStart) {
                        // Delete workflow
                        return true; // Allow the dismissal
                      } else if (direction == DismissDirection.startToEnd) {
                        // Clone workflow - don't actually dismiss
                        final clonedWorkoutId = await dao.cloneWorkout(removedWorkout.id);
                        final clonedWorkout = await dao.getWorkout(clonedWorkoutId);
                        
                        if (mounted) {
                          setState(() {
                            if (clonedWorkout != null) {
                              _workouts.insert(index + 1, clonedWorkout);
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Cloned ${removedWorkout.name}')),
                          );
                        }
                        return false; // Don't dismiss the original item
                      }
                      return false;
                    },
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        final removedWorkout = _workouts[index];
                        final dao = _workoutDao;
                        
                        await dao.deleteWorkout(removedWorkout.id);
                        if (mounted) {
                          setState(() {
                            _workouts.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Deleted ${removedWorkout.name}'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () async {
                                  await dao.createWorkout(
                                    WorkoutCompanion.insert(
                                      name: removedWorkout.name,
                                      description: drift.Value(removedWorkout.description),
                                    ),
                                  );
                                  _loadWorkouts();
                                },
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  WorkoutDetailScreen(workout: workout),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workout.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                workout.description ?? 'No description',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                              ),
                              const SizedBox(height: 12),
                              FutureBuilder(
                                future: _getWorkoutDetails(workout.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LinearProgressIndicator();
                                  }
                                  final details = snapshot.data;
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildDetailItem(
                                        Icons.timer,
                                        details?['time'] ?? 'N/A',
                                      ),
                                      _buildDetailItem(
                                        Icons.directions_run,
                                        details?['distance'] ?? 'N/A',
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const AddWorkoutScreen(),
            ),
          )
              .then((_) {
            _loadWorkouts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.blueGrey),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.blueGrey[800],
              ),
        ),
      ],
    );
  }

  // Add this method
  Future<Map<String, String>> _getWorkoutDetails(int workoutId) async {
    final blocks = await _workoutDao.getBlocksByWorkoutId(workoutId);
    final steps = await _workoutDao.getStepsByWorkoutId(workoutId);
    return {
      'time': WorkoutCalculator.calculateTotalTime(blocks, steps),
      'distance': WorkoutCalculator.calculateTotalDistance(blocks, steps),
    };
  }
}
