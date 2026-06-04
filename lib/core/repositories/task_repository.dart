import 'package:drift/drift.dart';

import '../database/app_database.dart' as db;
import '../models/beekeeper_task.dart';
import '../services/app_data_events.dart';

class TaskRepository {
  const TaskRepository(this._database);

  final db.AppDatabase _database;

  Future<List<BeekeeperTask>> getAllSorted() async {
    final rows = await _database.select(_database.tasks).get();
    final tasks = rows.map(_toModel).toList()
      ..sort((a, b) {
        if (a.isOpen != b.isOpen) {
          return a.isOpen ? -1 : 1;
        }
        return a.dueDate.compareTo(b.dueDate);
      });
    return tasks;
  }

  Future<List<BeekeeperTask>> getOpenForHive(String hiveId) async {
    final rows =
        await (_database.select(_database.tasks)..where(
              (table) =>
                  table.hiveId.equals(hiveId) &
                  table.status.equals(BeekeeperTaskStatus.open.name),
            ))
            .get();
    final tasks = rows.map(_toModel).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return tasks;
  }

  Future<BeekeeperTask> getById(String id) async {
    final row = await (_database.select(
      _database.tasks,
    )..where((table) => table.id.equals(id))).getSingle();
    return _toModel(row);
  }

  Future<void> upsert(BeekeeperTask task) async {
    await _database
        .into(_database.tasks)
        .insertOnConflictUpdate(
          db.TasksCompanion.insert(
            id: task.id,
            hiveId: task.hiveId,
            title: task.title,
            description: Value(task.description),
            category: task.category.name,
            dueDateTime: task.dueTime ?? task.dueDate,
            priority: task.priority.name,
            status: task.status.name,
            createdAt: task.createdAt,
            completedAt: Value(task.completedAt),
            updatedAt: DateTime.now(),
          ),
        );
    AppDataEvents.notifyChanged();
  }

  Future<void> complete(String taskId) async {
    final task = await getById(taskId);
    await upsert(
      task.copyWith(
        status: BeekeeperTaskStatus.done,
        completedAt: DateTime.now(),
      ),
    );
  }

  BeekeeperTask _toModel(db.Task row) {
    return BeekeeperTask(
      id: row.id,
      title: row.title,
      description: row.description,
      hiveId: row.hiveId,
      category: _categoryFromName(row.category),
      dueDate: DateTime(
        row.dueDateTime.year,
        row.dueDateTime.month,
        row.dueDateTime.day,
      ),
      dueTime: row.dueDateTime,
      status: _statusFromName(row.status),
      priority: _priorityFromName(row.priority),
      createdAt: row.createdAt,
      completedAt: row.completedAt,
    );
  }

  BeekeeperTaskCategory _categoryFromName(String value) {
    return BeekeeperTaskCategory.values.firstWhere(
      (category) => category.name == value,
      orElse: () => BeekeeperTaskCategory.other,
    );
  }

  BeekeeperTaskPriority _priorityFromName(String value) {
    return BeekeeperTaskPriority.values.firstWhere(
      (priority) => priority.name == value,
      orElse: () => BeekeeperTaskPriority.normal,
    );
  }

  BeekeeperTaskStatus _statusFromName(String value) {
    return BeekeeperTaskStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => BeekeeperTaskStatus.open,
    );
  }
}
