import 'package:drift/drift.dart';

import '../database/app_database.dart' as db;
import '../models/bee_stand.dart';
import '../services/app_data_events.dart';

class ApiaryRepository {
  const ApiaryRepository(this._database);

  final db.AppDatabase _database;

  Future<List<BeeStand>> getAll() async {
    final rows = await _database.select(_database.apiaries).get();
    return rows.map(_toModel).toList();
  }

  Future<List<BeeStand>> listApiaries() {
    return getAll();
  }

  Future<BeeStand> getById(String id) async {
    final row = await (_database.select(
      _database.apiaries,
    )..where((table) => table.id.equals(id))).getSingle();
    return _toModel(row);
  }

  Future<BeeStand> getApiaryById(String id) {
    return getById(id);
  }

  Future<void> upsert(BeeStand apiary) async {
    await _database
        .into(_database.apiaries)
        .insertOnConflictUpdate(
          db.ApiariesCompanion.insert(
            id: apiary.id,
            name: apiary.name,
            location: apiary.location,
            notes: Value(apiary.notes),
            createdAt: apiary.createdAt,
            updatedAt: apiary.updatedAt,
          ),
        );
    AppDataEvents.notifyChanged();
  }

  Future<void> createApiary(BeeStand apiary) {
    return upsert(apiary);
  }

  Future<void> updateApiary(BeeStand apiary) {
    return upsert(apiary);
  }

  BeeStand _toModel(db.Apiary row) {
    return BeeStand(
      id: row.id,
      name: row.name,
      location: row.location,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
