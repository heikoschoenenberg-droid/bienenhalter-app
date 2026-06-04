import '../database/app_database.dart';
import '../repositories/apiary_repository.dart';
import '../repositories/hive_repository.dart';
import '../repositories/inspection_repository.dart';
import '../repositories/task_repository.dart';
import '../seed/database_seed.dart';

class AppRepositories {
  AppRepositories.withDatabase(this.database)
    : apiaries = ApiaryRepository(database),
      hives = HiveRepository(database),
      inspections = InspectionRepository(database),
      tasks = TaskRepository(database);

  static final AppRepositories instance = AppRepositories.withDatabase(
    AppDatabase(),
  );

  final AppDatabase database;
  final ApiaryRepository apiaries;
  final HiveRepository hives;
  final InspectionRepository inspections;
  final TaskRepository tasks;

  Future<void> initialize() async {
    await DatabaseSeed(
      database: database,
      apiaryRepository: apiaries,
      hiveRepository: hives,
      inspectionRepository: inspections,
      taskRepository: tasks,
    ).seedIfEmpty();
  }
}
