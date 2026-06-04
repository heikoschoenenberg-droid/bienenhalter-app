import 'package:drift/drift.dart';

import '../database/app_database.dart' as db;
import '../models/inspection.dart';
import '../services/app_data_events.dart';

class InspectionRepository {
  const InspectionRepository(this._database);

  final db.AppDatabase _database;

  Future<List<Inspection>> getAll() async {
    final rows = await (_database.select(
      _database.inspections,
    )..orderBy([(table) => OrderingTerm.desc(table.inspectionDateTime)])).get();
    return rows.map(_toModel).toList();
  }

  Future<List<Inspection>> getForHive(String hiveId) async {
    final rows =
        await (_database.select(_database.inspections)
              ..where((table) => table.hiveId.equals(hiveId))
              ..orderBy([
                (table) => OrderingTerm.desc(table.inspectionDateTime),
              ]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<Inspection> getById(String id) async {
    final row = await (_database.select(
      _database.inspections,
    )..where((table) => table.id.equals(id))).getSingle();
    return _toModel(row);
  }

  Future<Inspection?> latestForHive(String hiveId) async {
    final row =
        await (_database.select(_database.inspections)
              ..where((table) => table.hiveId.equals(hiveId))
              ..orderBy([
                (table) => OrderingTerm.desc(table.inspectionDateTime),
              ])
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<Inspection?> getLatestForHive(String hiveId) {
    return latestForHive(hiveId);
  }

  Future<Inspection?> latest() async {
    final row =
        await (_database.select(_database.inspections)
              ..orderBy([
                (table) => OrderingTerm.desc(table.inspectionDateTime),
              ])
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<void> add(Inspection inspection) {
    return createInspection(inspection);
  }

  Future<void> createInspection(Inspection inspection) {
    return upsert(inspection);
  }

  Future<void> updateInspection(Inspection inspection) {
    return upsert(inspection);
  }

  Future<void> upsert(Inspection inspection) async {
    final now = DateTime.now();
    await _database
        .into(_database.inspections)
        .insertOnConflictUpdate(
          db.InspectionsCompanion.insert(
            id: inspection.id,
            hiveId: inspection.hiveId,
            inspectionDateTime: inspection.date,
            mood: inspection.mood,
            queenSeen: inspection.queenSeen,
            combPosition: inspection.combPosition,
            queenCellsSeen: inspection.queenCellsSeen,
            swarmCellsSeen: inspection.swarmCellsSeen,
            emergencyCellsSeen: inspection.emergencyCellsSeen,
            cellsRemoved: inspection.cellsRemoved,
            droneFrameFillLevel: inspection.droneFrameFillLevel,
            droneFrameRemoved: inspection.droneFrameRemoved,
            droneFrameRenewed: inspection.droneFrameRenewed,
            colonyStrength: inspection.colonyStrength,
            broodFrames: inspection.broodFrameCount,
            foodStatus: inspection.feedStatus,
            queenColor: inspection.queenColor,
            queenExcluderInserted: inspection.queenExcluderInserted,
            honeySupersCount: inspection.honeySuperCount,
            honeySuperFillLevel: inspection.honeySuperFillLevel,
            honeyCappingStatus: inspection.honeyCappingState,
            honeyWaterContent: Value(inspection.honeyWaterContent),
            beeEscapeInserted: inspection.beeEscapeInserted,
            varroaTreatmentDone: inspection.varroaTreatmentDone,
            varroaTreatmentType: inspection.varroaTreatment,
            feedingDone: inspection.feedingDone,
            feedingType: inspection.feedType,
            feedingAmount: Value(inspection.feedAmount),
            notes: Value(inspection.notes),
            createdAt: now,
            updatedAt: now,
          ),
        );
    AppDataEvents.notifyChanged();
  }

  Future<void> deleteInspection(String inspectionId) async {
    await (_database.delete(
      _database.inspections,
    )..where((table) => table.id.equals(inspectionId))).go();
    AppDataEvents.notifyChanged();
  }

  Inspection _toModel(db.Inspection row) {
    return Inspection(
      id: row.id,
      hiveId: row.hiveId,
      date: row.inspectionDateTime,
      mood: row.mood,
      queenSeen: row.queenSeen,
      combPosition: row.combPosition,
      queenCellsSeen: row.queenCellsSeen,
      swarmCellsSeen: row.swarmCellsSeen,
      emergencyCellsSeen: row.emergencyCellsSeen,
      cellsRemoved: row.cellsRemoved,
      droneFrameFillLevel: row.droneFrameFillLevel,
      droneFrameRemoved: row.droneFrameRemoved,
      droneFrameRenewed: row.droneFrameRenewed,
      colonyStrength: row.colonyStrength,
      broodFrameCount: row.broodFrames,
      feedStatus: row.foodStatus,
      queenColor: row.queenColor,
      queenExcluderInserted: row.queenExcluderInserted,
      honeySuperCount: row.honeySupersCount,
      honeySuperFillLevel: row.honeySuperFillLevel,
      honeyCappingState: row.honeyCappingStatus,
      honeyWaterContent: row.honeyWaterContent,
      beeEscapeInserted: row.beeEscapeInserted,
      varroaTreatmentDone: row.varroaTreatmentDone,
      varroaTreatment: row.varroaTreatmentType,
      feedingDone: row.feedingDone,
      feedType: row.feedingType,
      feedAmount: row.feedingAmount,
      notes: row.notes,
    );
  }
}
