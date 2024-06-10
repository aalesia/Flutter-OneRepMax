import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

import '../datasource/data_source.dart';
import '../entity/workout_record_entity.dart';

abstract class Repository {
  Future<List<WorkoutRecordEntity>> fetchWorkoutRecords();
}

class RepositoryImpl implements Repository {
  DataSource dataSource;

  RepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<List<WorkoutRecordEntity>> fetchWorkoutRecords() async {
    String workoutData = await rootBundle.loadString('assets/workoutdata.txt');

    workoutData.split('\n').forEach((line) {
      List<String> values = line.split(',');
      if (values.length == 4) {
        String dateString = values[0];
        String workout = values[1];
        int reps = int.parse(values[2]);
        int weight = int.parse(values[3]);

        DateFormat format = DateFormat("MMM dd yyyy");
        DateTime date = format.parse(dateString);

        dataSource.addWorkoutRecord(
            WorkoutRecordEntity(
                date: date,
                workout: workout,
                reps: reps,
                weight: weight
            )
        );
      }
    });

    return dataSource.getWorkoutRecords();
  }
}