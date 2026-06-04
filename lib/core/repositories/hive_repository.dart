import 'package:drift/drift.dart';

import '../database/app_database.dart' as db;
import '../models/hive.dart';

class HiveRepository {
  const HiveRepository(this._database);

  final db.AppDatabase _database;

  Future<List<Hive>> getAll() async {
    final rows = await (_database.select(
      _database.hives,
    )..orderBy([(table) => OrderingTerm.asc(table.hiveNumber)])).get();
    return Future.wait(rows.map(_toModel));
  }

  Future<List<Hive>> listHives() {
    return getAll();
  }

  Future<Hive> getById(String id) async {
    final row = await (_database.select(
      _database.hives,
    )..where((table) => table.id.equals(id))).getSingle();
    return _toModel(row);
  }

  Future<Hive> getHiveById(String id) {
    return getById(id);
  }

  Future<void> upsert(Hive hive) {
    return _database
        .into(_database.hives)
        .insertOnConflictUpdate(
          db.HivesCompanion.insert(
            id: hive.id,
            apiaryId: hive.beeStandId,
            hiveNumber: hive.number,
            name: Value(hive.name),
            hiveType: Value(hive.hiveType),
            queenYear: hive.queenYear,
            queenColor: hive.queenColor,
            queenOrigin: Value(hive.queenOrigin),
            status: hive.status.name,
            notes: Value(hive.notes),
            createdAt: hive.createdAt,
            updatedAt: hive.updatedAt,
          ),
        );
  }

  Future<void> createHive(Hive hive) {
    return upsert(hive);
  }

  Future<void> updateHive(Hive hive) {
    return upsert(hive);
  }

  Future<Hive> _toModel(db.Hive row) async {
    final latestInspection =
        await (_database.select(_database.inspections)
              ..where((table) => table.hiveId.equals(row.id))
              ..orderBy([
                (table) => OrderingTerm.desc(table.inspectionDateTime),
              ])
              ..limit(1))
            .getSingleOrNull();

    return Hive(
      id: row.id,
      number: row.hiveNumber,
      beeStandId: row.apiaryId,
      name: row.name,
      hiveType: row.hiveType,
      queenYear: row.queenYear,
      queenColor: row.queenColor,
      queenOrigin: row.queenOrigin,
      status: _statusFromName(row.status),
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      lastInspectionDate: latestInspection?.inspectionDateTime,
    );
  }

  HiveStatus _statusFromName(String value) {
    if (value == 'needsAttention') {
      return HiveStatus.active;
    }
    if (value == 'inactive') {
      return HiveStatus.dissolved;
    }

    return HiveStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => HiveStatus.active,
    );
  }
}
