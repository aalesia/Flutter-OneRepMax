import '../entity/workout_entity.dart';
import '../entity/workout_record_entity.dart';
import '../repository/repository.dart';
import '../utilities/utilities.dart';

class ParseWorkoutLogUseCase {
  Repository repository;

  ParseWorkoutLogUseCase({
    required this.repository,
  });

  Future<List<WorkoutEntity>> call() async {
    List<WorkoutRecordEntity> workoutRecords = await repository.fetchWorkoutRecords();
    Map<String, List<WorkoutRecordEntity>> groupedWorkoutRecords = groupBy(workoutRecords, (obj) => obj.workout);
    List<WorkoutEntity> sortedWorkoutRecords = groupedWorkoutRecords.entries.map((entry) {
      String workout = entry.key;
      List<WorkoutRecordEntity> records = entry.value;
      records.sort((a, b) => a.date.compareTo(b.date));
      int oneRepMax = calculateOneRepMax(records);
      return WorkoutEntity(name: workout, maxRep: oneRepMax, records: records);
    }).toList();
    sortedWorkoutRecords.sort((a, b) => a.name.compareTo(b.name));
    return sortedWorkoutRecords;
  }

  int calculateOneRepMax(List<WorkoutRecordEntity> workoutRecords) {
    workoutRecords.sort((a, b) => b.weight.compareTo(a.weight));
    int heaviestWeight = workoutRecords.first.weight;
    int heaviestWeightReps = workoutRecords.first.reps;
    return (heaviestWeight * (36 / (37 - heaviestWeightReps))).round();
  }
}