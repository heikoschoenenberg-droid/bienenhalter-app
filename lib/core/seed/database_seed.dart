import '../database/app_database.dart';
import '../demo/demo_data.dart';
import '../repositories/apiary_repository.dart';
import '../repositories/hive_repository.dart';
import '../repositories/inspection_repository.dart';
import '../repositories/task_repository.dart';

class DatabaseSeed {
  const DatabaseSeed({
    required AppDatabase database,
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
    required InspectionRepository inspectionRepository,
    required TaskRepository taskRepository,
  }) : this._(
         database,
         apiaryRepository,
         hiveRepository,
         inspectionRepository,
         taskRepository,
       );

  const DatabaseSeed._(
    this._database,
    this._apiaryRepository,
    this._hiveRepository,
    this._inspectionRepository,
    this._taskRepository,
  );

  final AppDatabase _database;
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;
  final InspectionRepository _inspectionRepository;
  final TaskRepository _taskRepository;

  Future<void> seedIfEmpty() async {
    final existingApiaries = await _database.select(_database.apiaries).get();
    if (existingApiaries.isNotEmpty) {
      return;
    }

    for (final apiary in DemoData.beeStands) {
      await _apiaryRepository.upsert(apiary);
    }

    for (final hive in DemoData.hives) {
      await _hiveRepository.upsert(hive);
    }

    for (final inspection in DemoData.inspections) {
      await _inspectionRepository.add(inspection);
    }

    for (final task in DemoData.tasks) {
      await _taskRepository.upsert(task);
    }
  }
}
