enum PhotoAttachmentType { hivePhoto, inspectionPhoto, stockCardImport }

class PhotoAttachment {
  const PhotoAttachment({
    required this.id,
    required this.localPath,
    required this.filename,
    required this.linkedHiveId,
    required this.linkedInspectionId,
    required this.type,
    required this.createdAt,
    required this.notes,
  });

  final String id;
  final String localPath;
  final String filename;
  final String? linkedHiveId;
  final String? linkedInspectionId;
  final PhotoAttachmentType type;
  final DateTime createdAt;
  final String notes;

  PhotoAttachment copyWith({
    String? id,
    String? localPath,
    String? filename,
    String? linkedHiveId,
    bool clearLinkedHiveId = false,
    String? linkedInspectionId,
    bool clearLinkedInspectionId = false,
    PhotoAttachmentType? type,
    DateTime? createdAt,
    String? notes,
  }) {
    return PhotoAttachment(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      filename: filename ?? this.filename,
      linkedHiveId: clearLinkedHiveId
          ? null
          : linkedHiveId ?? this.linkedHiveId,
      linkedInspectionId: clearLinkedInspectionId
          ? null
          : linkedInspectionId ?? this.linkedInspectionId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }
}
