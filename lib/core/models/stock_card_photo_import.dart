import 'dart:typed_data';

enum StockCardPhotoImportStatus {
  imported,
  assigned,
  draftCreated,
  processed,
  error,
}

class StockCardPhotoImport {
  const StockCardPhotoImport({
    required this.id,
    required this.filename,
    required this.path,
    required this.hiveId,
    required this.status,
    required this.createdAt,
    required this.notes,
    required this.bytes,
  });

  final String id;
  final String filename;
  final String? path;
  final String? hiveId;
  final StockCardPhotoImportStatus status;
  final DateTime createdAt;
  final String notes;
  final Uint8List? bytes;

  StockCardPhotoImport copyWith({
    String? id,
    String? filename,
    String? path,
    String? hiveId,
    bool clearHiveId = false,
    StockCardPhotoImportStatus? status,
    DateTime? createdAt,
    String? notes,
    Uint8List? bytes,
  }) {
    return StockCardPhotoImport(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      path: path ?? this.path,
      hiveId: clearHiveId ? null : hiveId ?? this.hiveId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
      bytes: bytes ?? this.bytes,
    );
  }

  String get statusLabel {
    return switch (status) {
      StockCardPhotoImportStatus.imported => 'Noch nicht ausgewertet',
      StockCardPhotoImportStatus.assigned => 'Volk zugeordnet',
      StockCardPhotoImportStatus.draftCreated => 'Kontrolle erstellt',
      StockCardPhotoImportStatus.processed => 'Verarbeitet',
      StockCardPhotoImportStatus.error => 'Fehler',
    };
  }
}
