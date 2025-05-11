import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_workout/database/schema.dart';
import 'package:runner_workout/my_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  runApp(
    Provider<AppDatabase>.value(
      value: db,
      child: const MyApp(),
    ),
  );
}

// Update MyApp to use WorkoutListScreen as home
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Runner Workout',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const WorkoutListScreen(),
    );
  }
}
