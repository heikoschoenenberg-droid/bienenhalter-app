enum HoneyProcessingType { creamy, liquid }

extension HoneyProcessingTypeLabel on HoneyProcessingType {
  String get label {
    return switch (this) {
      HoneyProcessingType.creamy => 'cremig',
      HoneyProcessingType.liquid => 'flüssig',
    };
  }
}

class HoneyBookEntry {
  const HoneyBookEntry({
    required this.id,
    required this.runningNumber,
    required this.harvestDate,
    required this.extractionLocation,
    required this.honeyType,
    required this.waterContentPercent,
    required this.amountKg,
    required this.bottledAt,
    required this.labelNumberFrom,
    required this.labelNumberTo,
    required this.batchNumber,
    required this.bestBeforeDate,
    required this.processingType,
    required this.notes,
    required this.originNote,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String runningNumber;
  final DateTime harvestDate;
  final String extractionLocation;
  final String honeyType;
  final double? waterContentPercent;
  final double amountKg;
  final DateTime? bottledAt;
  final String labelNumberFrom;
  final String labelNumberTo;
  final String batchNumber;
  final DateTime? bestBeforeDate;
  final HoneyProcessingType processingType;
  final String notes;
  final String originNote;
  final DateTime createdAt;
  final DateTime updatedAt;

  HoneyBookEntry copyWith({
    String? id,
    String? runningNumber,
    DateTime? harvestDate,
    String? extractionLocation,
    String? honeyType,
    double? waterContentPercent,
    bool clearWaterContentPercent = false,
    double? amountKg,
    DateTime? bottledAt,
    bool clearBottledAt = false,
    String? labelNumberFrom,
    String? labelNumberTo,
    String? batchNumber,
    DateTime? bestBeforeDate,
    bool clearBestBeforeDate = false,
    HoneyProcessingType? processingType,
    String? notes,
    String? originNote,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HoneyBookEntry(
      id: id ?? this.id,
      runningNumber: runningNumber ?? this.runningNumber,
      harvestDate: harvestDate ?? this.harvestDate,
      extractionLocation: extractionLocation ?? this.extractionLocation,
      honeyType: honeyType ?? this.honeyType,
      waterContentPercent: clearWaterContentPercent
          ? null
          : waterContentPercent ?? this.waterContentPercent,
      amountKg: amountKg ?? this.amountKg,
      bottledAt: clearBottledAt ? null : bottledAt ?? this.bottledAt,
      labelNumberFrom: labelNumberFrom ?? this.labelNumberFrom,
      labelNumberTo: labelNumberTo ?? this.labelNumberTo,
      batchNumber: batchNumber ?? this.batchNumber,
      bestBeforeDate: clearBestBeforeDate
          ? null
          : bestBeforeDate ?? this.bestBeforeDate,
      processingType: processingType ?? this.processingType,
      notes: notes ?? this.notes,
      originNote: originNote ?? this.originNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
