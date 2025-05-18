import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner_workout/database/schema.dart';
import 'package:runner_workout/my_home_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final db = AppDatabase();
  runApp(
    Provider<AppDatabase>.value(
      value: db,
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
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
      ),
      home: const WorkoutListScreen(),
    );
  }
}
