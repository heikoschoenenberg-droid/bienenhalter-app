import 'package:drift/drift.dart';

import '../database/app_database.dart' as db;
import '../models/photo_attachment.dart';
import '../services/app_data_events.dart';

class PhotoAttachmentRepository {
  const PhotoAttachmentRepository(this._database);

  final db.AppDatabase _database;

  Future<List<PhotoAttachment>> getForHive(String hiveId) async {
    final rows =
        await (_database.select(_database.photoAttachments)
              ..where(
                (table) =>
                    table.linkedHiveId.equals(hiveId) &
                    table.type.equals(PhotoAttachmentType.hivePhoto.name),
              )
              ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<List<PhotoAttachment>> getForInspection(String inspectionId) async {
    final rows =
        await (_database.select(_database.photoAttachments)
              ..where((table) => table.linkedInspectionId.equals(inspectionId))
              ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]))
            .get();
    return rows.map(_toModel).toList();
  }

  Future<void> upsert(PhotoAttachment photo) async {
    await _database
        .into(_database.photoAttachments)
        .insertOnConflictUpdate(
          db.PhotoAttachmentsCompanion.insert(
            id: photo.id,
            localPath: photo.localPath,
            filename: photo.filename,
            linkedHiveId: Value(photo.linkedHiveId),
            linkedInspectionId: Value(photo.linkedInspectionId),
            type: photo.type.name,
            createdAt: photo.createdAt,
            notes: Value(photo.notes),
          ),
        );
    AppDataEvents.notifyChanged();
  }

  Future<void> upsertAll(Iterable<PhotoAttachment> photos) async {
    for (final photo in photos) {
      await upsert(photo);
    }
  }

  Future<void> delete(String photoId) async {
    await (_database.delete(
      _database.photoAttachments,
    )..where((table) => table.id.equals(photoId))).go();
    AppDataEvents.notifyChanged();
  }

  PhotoAttachment _toModel(db.PhotoAttachment row) {
    return PhotoAttachment(
      id: row.id,
      localPath: row.localPath,
      filename: row.filename,
      linkedHiveId: row.linkedHiveId,
      linkedInspectionId: row.linkedInspectionId,
      type: PhotoAttachmentType.values.firstWhere(
        (type) => type.name == row.type,
        orElse: () => PhotoAttachmentType.hivePhoto,
      ),
      createdAt: row.createdAt,
      notes: row.notes,
    );
  }
}
