import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:one_rep_max/usecase/get_days_from_records_use_case.dart';
import 'package:one_rep_max/usecase/get_max_weight_per_day_list_use_case.dart';

import '../entity/workout_entity.dart';

class WorkoutDetailsViewModel extends ChangeNotifier {
  late GetDaysFromRecordsUseCase getDaysFromRecordsUseCase;
  late GetMaxWeightPerDayListUseCase getMaxWeightPerDayListUseCase;

  WorkoutDetailsViewModel() {
    getDaysFromRecordsUseCase = GetDaysFromRecordsUseCase();
    getMaxWeightPerDayListUseCase = GetMaxWeightPerDayListUseCase();
  }

  final _workoutDaysAndMaxWeights = StreamController<List<List<double>>>();
  Stream<List<List<double>>> get workoutDaysAndMaxWeights => _workoutDaysAndMaxWeights.stream;

  Future<void> getWorkoutDaysAndMaxWeights(WorkoutEntity workout) async {
    List<double> days = await getDaysFromRecordsUseCase(workout.records);
    List<double> maxWeights = await getMaxWeightPerDayListUseCase(workout.records);
    _workoutDaysAndMaxWeights.add([days, maxWeights]);
  }
}