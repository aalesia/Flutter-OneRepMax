class WorkoutRecordEntity {
  DateTime date;
  String workout;
  int reps;
  int weight;

  WorkoutRecordEntity({
    required this.date,
    required this.workout,
    required this.reps,
    required this.weight,
  });
}