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
    required this.droneFrameFillLevel,
    required this.droneFrameRemoved,
    required this.colonyStrength,
    required this.broodFrameCount,
    required this.queenExcluderInserted,
    required this.honeySuperCount,
    required this.honeySuperFillLevel,
    required this.honeyCappingState,
    required this.honeyWaterContent,
    required this.beeEscapeInserted,
    required this.varroaTreatment,
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
  final String droneFrameFillLevel;
  final bool droneFrameRemoved;
  final String colonyStrength;
  final int broodFrameCount;
  final bool queenExcluderInserted;
  final int honeySuperCount;
  final String honeySuperFillLevel;
  final String honeyCappingState;
  final double? honeyWaterContent;
  final bool beeEscapeInserted;
  final String varroaTreatment;
  final String notes;
}
