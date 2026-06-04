import '../models/bee_stand.dart';
import '../models/beekeeper_task.dart';
import '../models/hive.dart';
import '../models/inspection.dart';

class DemoData {
  const DemoData._();

  static final DateTime today = DateTime(2026, 6, 4);

  static final List<BeeStand> beeStands = [
    const BeeStand(
      id: 'stand-garden',
      name: 'Hausgarten',
      location: 'Am Apfelbaum',
    ),
    const BeeStand(
      id: 'stand-meadow',
      name: 'Waldwiese',
      location: 'Nordrand der Wiese',
    ),
  ];

  static final List<Hive> hives = [
    Hive(
      id: 'hive-1',
      number: 'Volk 1',
      beeStandId: 'stand-garden',
      queenYear: 2025,
      queenColor: 'Blau',
      status: HiveStatus.active,
      lastInspectionDate: DateTime(2026, 6, 2, 10, 15),
    ),
    Hive(
      id: 'hive-2',
      number: 'Volk 2',
      beeStandId: 'stand-garden',
      queenYear: 2024,
      queenColor: 'Gruen',
      status: HiveStatus.needsAttention,
      lastInspectionDate: DateTime(2026, 5, 25, 9, 45),
    ),
    Hive(
      id: 'hive-3',
      number: 'Volk 3',
      beeStandId: 'stand-meadow',
      queenYear: 2026,
      queenColor: 'Weiss',
      status: HiveStatus.active,
      lastInspectionDate: DateTime(2026, 6, 1, 16, 10),
    ),
    Hive(
      id: 'hive-4',
      number: 'Ableger 1',
      beeStandId: 'stand-meadow',
      queenYear: 2026,
      queenColor: 'Weiss',
      status: HiveStatus.inactive,
      lastInspectionDate: null,
    ),
  ];

  static final List<Inspection> inspections = [
    Inspection(
      id: 'inspection-1',
      hiveId: 'hive-1',
      date: DateTime(2026, 6, 2, 10, 15),
      mood: 'ruhig',
      queenSeen: true,
      combPosition: 'mittig auf 7 Waben',
      queenCellsSeen: false,
      swarmCellsSeen: false,
      emergencyCellsSeen: false,
      droneFrameFillLevel: 'halb gefuellt',
      droneFrameRemoved: false,
      colonyStrength: 'stark',
      broodFrameCount: 7,
      queenExcluderInserted: true,
      honeySuperCount: 2,
      honeySuperFillLevel: 'ca. 60 Prozent',
      honeyCappingState: 'teilweise verdeckelt',
      honeyWaterContent: 18.2,
      beeEscapeInserted: false,
      varroaTreatment: 'keine Behandlung offen',
      notes: 'Brutnest geschlossen, Futter ausreichend.',
    ),
    Inspection(
      id: 'inspection-2',
      hiveId: 'hive-2',
      date: DateTime(2026, 5, 25, 9, 45),
      mood: 'nervoes',
      queenSeen: false,
      combPosition: 'breit auf 8 Waben',
      queenCellsSeen: true,
      swarmCellsSeen: true,
      emergencyCellsSeen: false,
      droneFrameFillLevel: 'voll',
      droneFrameRemoved: true,
      colonyStrength: 'sehr stark',
      broodFrameCount: 8,
      queenExcluderInserted: true,
      honeySuperCount: 2,
      honeySuperFillLevel: 'fast voll',
      honeyCappingState: 'mehrheitlich unverdeckelt',
      honeyWaterContent: 19.1,
      beeEscapeInserted: false,
      varroaTreatment: 'Sommerbehandlung planen',
      notes: 'Schwarmstimmung beobachten und zeitnah nachsehen.',
    ),
    Inspection(
      id: 'inspection-3',
      hiveId: 'hive-3',
      date: DateTime(2026, 6, 1, 16, 10),
      mood: 'ruhig',
      queenSeen: true,
      combPosition: 'kompakt auf 5 Waben',
      queenCellsSeen: false,
      swarmCellsSeen: false,
      emergencyCellsSeen: false,
      droneFrameFillLevel: 'leer',
      droneFrameRemoved: false,
      colonyStrength: 'mittel',
      broodFrameCount: 5,
      queenExcluderInserted: false,
      honeySuperCount: 1,
      honeySuperFillLevel: 'gering',
      honeyCappingState: 'kaum verdeckelt',
      honeyWaterContent: null,
      beeEscapeInserted: false,
      varroaTreatment: 'Kontrolle nach Trachtende',
      notes: 'Junge Koenigin in Eiablage.',
    ),
    Inspection(
      id: 'inspection-4',
      hiveId: 'hive-1',
      date: DateTime(2026, 5, 22, 11, 30),
      mood: 'ruhig',
      queenSeen: false,
      combPosition: 'mittig',
      queenCellsSeen: false,
      swarmCellsSeen: false,
      emergencyCellsSeen: false,
      droneFrameFillLevel: 'angelegt',
      droneFrameRemoved: false,
      colonyStrength: 'stark',
      broodFrameCount: 6,
      queenExcluderInserted: true,
      honeySuperCount: 1,
      honeySuperFillLevel: 'halb voll',
      honeyCappingState: 'unverdeckt',
      honeyWaterContent: null,
      beeEscapeInserted: false,
      varroaTreatment: 'keine',
      notes: 'Honigraum erweitert.',
    ),
  ];

  static final List<BeekeeperTask> tasks = [
    BeekeeperTask(
      id: 'task-1',
      title: 'Volk 2 erneut auf Schwarmzellen pruefen',
      hiveId: 'hive-2',
      category: BeekeeperTaskCategory.inspection,
      dueDate: DateTime(2026, 6, 4),
      status: BeekeeperTaskStatus.open,
    ),
    BeekeeperTask(
      id: 'task-2',
      title: 'Futtervorrat bei Ableger 1 kontrollieren',
      hiveId: 'hive-4',
      category: BeekeeperTaskCategory.feeding,
      dueDate: DateTime(2026, 6, 8),
      status: BeekeeperTaskStatus.open,
    ),
    BeekeeperTask(
      id: 'task-3',
      title: 'Honigraum bei Volk 1 aufsetzen',
      hiveId: 'hive-1',
      category: BeekeeperTaskCategory.honeySuper,
      dueDate: DateTime(2026, 5, 31),
      status: BeekeeperTaskStatus.done,
    ),
    BeekeeperTask(
      id: 'task-4',
      title: 'Bienenflucht bei Volk 1 pruefen',
      hiveId: 'hive-1',
      category: BeekeeperTaskCategory.beeEscape,
      dueDate: DateTime(2026, 6, 5),
      status: BeekeeperTaskStatus.open,
    ),
    BeekeeperTask(
      id: 'task-5',
      title: 'Varroa-Plan fuer Volk 3 vorbereiten',
      hiveId: 'hive-3',
      category: BeekeeperTaskCategory.varroa,
      dueDate: DateTime(2026, 6, 10),
      status: BeekeeperTaskStatus.open,
    ),
    BeekeeperTask(
      id: 'task-6',
      title: 'Koeniginnenzeichnung bei Ableger 1 nachtragen',
      hiveId: 'hive-4',
      category: BeekeeperTaskCategory.queen,
      dueDate: DateTime(2026, 6, 12),
      status: BeekeeperTaskStatus.open,
    ),
  ];

  static BeeStand beeStandById(String id) {
    return beeStands.firstWhere((beeStand) => beeStand.id == id);
  }

  static Hive hiveById(String id) {
    return hives.firstWhere((hive) => hive.id == id);
  }

  static List<Inspection> inspectionsForHive(String hiveId) {
    return inspections
        .where((inspection) => inspection.hiveId == hiveId)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  static Inspection? latestInspectionForHive(String hiveId) {
    final hiveInspections = inspectionsForHive(hiveId);
    if (hiveInspections.isEmpty) {
      return null;
    }

    return hiveInspections.first;
  }

  static List<BeekeeperTask> tasksForHive(String hiveId) {
    return tasks.where((task) => task.hiveId == hiveId).toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  static List<BeekeeperTask> openTasksForHive(String hiveId) {
    return tasksForHive(hiveId).where((task) => task.isOpen).toList();
  }

  static List<BeekeeperTask> sortedTasks() {
    final sortedTasks = [...tasks]
      ..sort((a, b) {
        if (a.isOpen != b.isOpen) {
          return a.isOpen ? -1 : 1;
        }

        return a.dueDate.compareTo(b.dueDate);
      });
    return sortedTasks;
  }

  static List<String> warningsForHive(String hiveId) {
    final hive = hiveById(hiveId);
    final warnings = <String>{};

    if (hive.lastInspectionDate == null ||
        today.difference(hive.lastInspectionDate!).inDays >= 7) {
      warnings.add('Kontrolle faellig');
    }

    for (final task in openTasksForHive(hiveId)) {
      if (!task.dueDate.isAfter(today.add(const Duration(days: 7)))) {
        warnings.add(task.warningLabel);
      }
    }

    return warnings.toList();
  }

  static Inspection? get latestInspection {
    if (inspections.isEmpty) {
      return null;
    }

    final sortedInspections = [...inspections]
      ..sort((a, b) => b.date.compareTo(a.date));
    return sortedInspections.first;
  }
}
