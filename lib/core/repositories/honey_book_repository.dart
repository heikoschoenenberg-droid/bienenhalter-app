import 'package:drift/drift.dart';

import '../database/app_database.dart' as db;
import '../models/honey_book_entry.dart';
import '../services/app_data_events.dart';

class HoneyBookRepository {
  const HoneyBookRepository(this._database);

  final db.AppDatabase _database;

  Future<List<HoneyBookEntry>> listHoneyBookEntries() async {
    final rows = await (_database.select(
      _database.honeyBookEntries,
    )..orderBy([(table) => OrderingTerm.desc(table.harvestDate)])).get();
    return rows.map(_toModel).toList();
  }

  Future<HoneyBookEntry> getHoneyBookEntryById(String id) async {
    final row = await (_database.select(
      _database.honeyBookEntries,
    )..where((table) => table.id.equals(id))).getSingle();
    return _toModel(row);
  }

  Future<void> createHoneyBookEntry(HoneyBookEntry entry) {
    return upsert(entry);
  }

  Future<void> updateHoneyBookEntry(HoneyBookEntry entry) {
    return upsert(entry);
  }

  Future<void> upsert(HoneyBookEntry entry) async {
    await _database
        .into(_database.honeyBookEntries)
        .insertOnConflictUpdate(
          db.HoneyBookEntriesCompanion.insert(
            id: entry.id,
            runningNumber: entry.runningNumber,
            harvestDate: entry.harvestDate,
            extractionLocation: entry.extractionLocation,
            honeyType: entry.honeyType,
            waterContentPercent: Value(entry.waterContentPercent),
            amountKg: entry.amountKg,
            bottledAt: Value(entry.bottledAt),
            labelNumberFrom: Value(entry.labelNumberFrom),
            labelNumberTo: Value(entry.labelNumberTo),
            batchNumber: Value(entry.batchNumber),
            bestBeforeDate: Value(entry.bestBeforeDate),
            processingType: entry.processingType.name,
            notes: Value(entry.notes),
            originNote: Value(entry.originNote),
            createdAt: entry.createdAt,
            updatedAt: entry.updatedAt,
          ),
        );
    AppDataEvents.notifyChanged();
  }

  Future<void> deleteHoneyBookEntry(String id) async {
    await (_database.delete(
      _database.honeyBookEntries,
    )..where((table) => table.id.equals(id))).go();
    AppDataEvents.notifyChanged();
  }

  HoneyBookEntry _toModel(db.HoneyBookEntry row) {
    return HoneyBookEntry(
      id: row.id,
      runningNumber: row.runningNumber,
      harvestDate: row.harvestDate,
      extractionLocation: row.extractionLocation,
      honeyType: row.honeyType,
      waterContentPercent: row.waterContentPercent,
      amountKg: row.amountKg,
      bottledAt: row.bottledAt,
      labelNumberFrom: row.labelNumberFrom,
      labelNumberTo: row.labelNumberTo,
      batchNumber: row.batchNumber,
      bestBeforeDate: row.bestBeforeDate,
      processingType: HoneyProcessingType.values.firstWhere(
        (type) => type.name == row.processingType,
        orElse: () => HoneyProcessingType.liquid,
      ),
      notes: row.notes,
      originNote: row.originNote,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
