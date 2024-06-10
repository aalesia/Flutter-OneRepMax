import '../entity/workout_record_entity.dart';

abstract class DataSource {
  void addWorkoutRecord(WorkoutRecordEntity workoutRecord);
  List<WorkoutRecordEntity> getWorkoutRecords();
}

class DataSourceImpl implements DataSource {
  final List<WorkoutRecordEntity> _workoutRecords = [];

  @override
  void addWorkoutRecord(WorkoutRecordEntity workoutRecord) {
    _workoutRecords.add(workoutRecord);
  }

  @override
  List<WorkoutRecordEntity> getWorkoutRecords() {
    return _workoutRecords;
  }
}