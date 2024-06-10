import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../entity/workout_entity.dart';
import '../viewmodel/workout_details_view_model.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final WorkoutEntity workout;

  const WorkoutDetailsScreen({super.key, required this.workout});

  @override
  WorkoutDetailsScreenState createState() => WorkoutDetailsScreenState();
}

class WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutDetailsViewModel>(context, listen: false)
        .getWorkoutDaysAndMaxWeights(widget.workout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.name),
      ),
      body: StreamBuilder<List<List<double>>>(
        stream: Provider
            .of<WorkoutDetailsViewModel>(context)
            .workoutDaysAndMaxWeights,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<List<double>> data = snapshot.data!;
            List<FlSpot> spots = data[0]
                .asMap()
                .map((index, day) =>
                MapEntry(index, FlSpot(day, data[1][index])))
                .values
                .toList();

            return LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: false,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}