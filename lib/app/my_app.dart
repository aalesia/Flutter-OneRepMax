import 'package:flutter/material.dart';
import 'package:one_rep_max/entity/workout_entity.dart';
import 'package:provider/provider.dart';

import '../screen/workout_details_screen.dart';
import '../screen/workout_screen.dart';
import '../viewmodel/workout_details_view_model.dart';
import '../viewmodel/workouts_view_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workouts App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            key: const ValueKey('WorkoutsScreen'),
            child: ChangeNotifierProvider(
              create: (context) => WorkoutsViewModel(),
              child: const WorkoutsScreen(),
            ),
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}