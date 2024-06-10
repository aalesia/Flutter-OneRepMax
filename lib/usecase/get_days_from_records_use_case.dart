import '../entity/workout_record_entity.dart';
import '../utilities/utilities.dart';

class GetDaysFromRecordsUseCase {
  Future<List<double>> call(List<WorkoutRecordEntity> workoutRecords) async {
    var groupedRecords = groupBy(workoutRecords, (obj) => obj.date);
    var entries = groupedRecords.entries.toList();

    entries.sort((a, b) {
      return a.key.compareTo(b.key);
    });

    groupedRecords = Map.fromEntries(entries);
    return groupedRecords.keys.map((date) => date.millisecondsSinceEpoch.toDouble()).toList();
  }
}