import 'package:one_rep_max/entity/workout_record_entity.dart';

class WorkoutEntity {
  String name;
  int maxRep;
  List<WorkoutRecordEntity> records;

  WorkoutEntity({
    required this.name,
    required this.maxRep,
    required this.records,
  });
}