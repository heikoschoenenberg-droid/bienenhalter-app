enum HiveStatus { active, needsAttention, inactive }

class Hive {
  const Hive({
    required this.id,
    required this.number,
    required this.beeStandId,
    required this.queenYear,
    required this.queenColor,
    required this.status,
    required this.lastInspectionDate,
  });

  final String id;
  final String number;
  final String beeStandId;
  final int queenYear;
  final String queenColor;
  final HiveStatus status;
  final DateTime? lastInspectionDate;

  String get statusLabel {
    return switch (status) {
      HiveStatus.active => 'Aktiv',
      HiveStatus.needsAttention => 'Beobachten',
      HiveStatus.inactive => 'Inaktiv',
    };
  }
}
