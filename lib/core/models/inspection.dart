class Inspection {
  const Inspection({
    required this.id,
    required this.hiveId,
    required this.date,
    required this.mood,
    required this.queenSeen,
    required this.combPosition,
    required this.queenCellsSeen,
    required this.swarmCellsSeen,
    required this.emergencyCellsSeen,
    required this.cellsRemoved,
    required this.droneFrameFillLevel,
    required this.droneFrameRemoved,
    required this.droneFrameRenewed,
    required this.colonyStrength,
    required this.broodFrameCount,
    required this.feedStatus,
    required this.queenColor,
    required this.queenExcluderInserted,
    required this.honeySuperCount,
    required this.honeySuperFillLevel,
    required this.honeyCappingState,
    required this.honeyWaterContent,
    required this.beeEscapeInserted,
    required this.varroaTreatmentDone,
    required this.varroaTreatment,
    required this.feedingDone,
    required this.feedType,
    required this.feedAmount,
    required this.notes,
  });

  final String id;
  final String hiveId;
  final DateTime date;
  final String mood;
  final bool queenSeen;
  final String combPosition;
  final bool queenCellsSeen;
  final bool swarmCellsSeen;
  final bool emergencyCellsSeen;
  final bool cellsRemoved;
  final String droneFrameFillLevel;
  final bool droneFrameRemoved;
  final bool droneFrameRenewed;
  final int colonyStrength;
  final int broodFrameCount;
  final String feedStatus;
  final String queenColor;
  final bool queenExcluderInserted;
  final int honeySuperCount;
  final String honeySuperFillLevel;
  final String honeyCappingState;
  final double? honeyWaterContent;
  final bool beeEscapeInserted;
  final bool varroaTreatmentDone;
  final String varroaTreatment;
  final bool feedingDone;
  final String feedType;
  final double? feedAmount;
  final String notes;
}
