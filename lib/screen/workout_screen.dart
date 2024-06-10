import 'package:flutter/material.dart';
import 'package:one_rep_max/screen/workout_details_screen.dart';
import 'package:provider/provider.dart';

import '../viewmodel/workout_details_view_model.dart';
import '../viewmodel/workouts_view_model.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  WorkoutsScreenState createState() => WorkoutsScreenState();
}

class WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutsViewModel>(context, listen: false).getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: Consumer<WorkoutsViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.workouts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(viewModel.workouts[index].name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => WorkoutDetailsViewModel(),
                        child: WorkoutDetailsScreen(workout: viewModel.workouts[index]),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}