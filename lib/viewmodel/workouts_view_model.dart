import 'package:flutter/foundation.dart';

import '../datasource/data_source.dart';
import '../entity/workout_entity.dart';
import '../repository/repository.dart';
import '../usecase/parse_workout_log_use_case.dart';

class WorkoutsViewModel extends ChangeNotifier {
  late DataSourceImpl dataSource;
  late RepositoryImpl repository;
  late ParseWorkoutLogUseCase parseWorkoutLogUseCase;

  WorkoutsViewModel() {
    dataSource = DataSourceImpl();
    repository = RepositoryImpl(dataSource: dataSource);
    parseWorkoutLogUseCase = ParseWorkoutLogUseCase(repository: repository);
  }

  final List<WorkoutEntity> _workouts = [];
  List<WorkoutEntity> get workouts => _workouts;

  Future<void> getWorkouts() async {
    try {
      List<WorkoutEntity> fetchedWorkouts = await parseWorkoutLogUseCase.call();
      _workouts.addAll(fetchedWorkouts);
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      // Handle any errors here
    }
  }
}