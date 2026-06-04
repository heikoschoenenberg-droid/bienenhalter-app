enum HiveStatus { active, needsAttention, inactive }

class Hive {
  const Hive({
    required this.id,
    required this.number,
    required this.beeStandId,
    required this.name,
    required this.hiveType,
    required this.queenYear,
    required this.queenColor,
    required this.queenOrigin,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.lastInspectionDate,
  });

  final String id;
  final String number;
  final String beeStandId;
  final String name;
  final String hiveType;
  final int queenYear;
  final String queenColor;
  final String queenOrigin;
  final HiveStatus status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastInspectionDate;

  String get statusLabel {
    return switch (status) {
      HiveStatus.active => 'Aktiv',
      HiveStatus.needsAttention => 'Beobachten',
      HiveStatus.inactive => 'Inaktiv',
    };
  }
}
