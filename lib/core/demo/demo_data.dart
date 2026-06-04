import '../models/bee_stand.dart';
import '../models/beekeeper_task.dart';
import '../models/hive.dart';
import '../models/inspection.dart';

class DemoData {
  const DemoData._();

  static final DateTime today = DateTime(2026, 6, 4);

  static final List<BeeStand> beeStands = [
    BeeStand(
      id: 'stand-garden',
      name: 'Hausgarten',
      location: 'Am Apfelbaum',
      notes: 'Gut erreichbar, Wasser in der Naehe.',
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
    BeeStand(
      id: 'stand-meadow',
      name: 'Waldwiese',
      location: 'Nordrand der Wiese',
      notes: 'Ruhiger Standort am Waldrand.',
      createdAt: DateTime(2026, 1, 1),
      updatedAt: DateTime(2026, 1, 1),
    ),
  ];

  static final List<Hive> hives = [
    Hive(
      id: 'hive-1',
      number: 'Volk 1',
      beeStandId: 'stand-garden',
      name: 'Apfelbaum stark',
      hiveType: 'Zander Magazin',
      queenYear: 2025,
      queenColor: 'Blau',
      queenOrigin: 'eigene Nachzucht',
      status: HiveStatus.active,
      notes: 'Starkes Wirtschaftsvolk.',
      createdAt: DateTime(2026, 1, 10),
      updatedAt: DateTime(2026, 6, 2),
      lastInspectionDate: DateTime(2026, 6, 2, 10, 15),
    ),
    Hive(
      id: 'hive-2',
      number: 'Volk 2',
      beeStandId: 'stand-garden',
      name: 'Garten Beobachtung',
      hiveType: 'Zander Magazin',
      queenYear: 2024,
      queenColor: 'Gruen',
      queenOrigin: 'Zuchtkoenigin',
      status: HiveStatus.needsAttention,
      notes: 'Schwarmstimmung im Auge behalten.',
      createdAt: DateTime(2026, 1, 10),
      updatedAt: DateTime(2026, 5, 25),
      lastInspectionDate: DateTime(2026, 5, 25, 9, 45),
    ),
    Hive(
      id: 'hive-3',
      number: 'Volk 3',
      beeStandId: 'stand-meadow',
      name: 'Wiesenvolk',
      hiveType: 'Dadant',
      queenYear: 2026,
      queenColor: 'Weiss',
      queenOrigin: 'Ableger',
      status: HiveStatus.active,
      notes: 'Junge Koenigin in Eiablage.',
      createdAt: DateTime(2026, 3, 12),
      updatedAt: DateTime(2026, 6, 1),
      lastInspectionDate: DateTime(2026, 6, 1, 16, 10),
    ),
    Hive(
      id: 'hive-4',
      number: 'Ableger 1',
      beeStandId: 'stand-meadow',
      name: 'Ableger Waldwiese',
      hiveType: 'Ablegerkasten',
      queenYear: 2026,
      queenColor: 'Weiss',
      queenOrigin: 'Nachschaffung',
      status: HiveStatus.inactive,
      notes: 'Noch im Aufbau.',
      createdAt: DateTime(2026, 5, 1),
      updatedAt: DateTime(2026, 6, 2),
      lastInspectionDate: null,
    ),
    Hive(
      id: 'hive-5',
      number: 'Volk 5',
      beeStandId: 'stand-meadow',
      name: 'Robinientracht',
      hiveType: 'Zander Magazin',
      queenYear: 2025,
      queenColor: 'Blau',
      queenOrigin: 'zugekauft',
      status: HiveStatus.active,
      notes: 'Mittleres Volk mit gutem Futterkranz.',
      createdAt: DateTime(2026, 2, 15),
      updatedAt: DateTime(2026, 5, 29),
      lastInspectionDate: DateTime(2026, 5, 29, 15, 20),
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
      cellsRemoved: false,
      droneFrameFillLevel: 'halb gefuellt',
      droneFrameRemoved: false,
      droneFrameRenewed: false,
      colonyStrength: 8,
      broodFrameCount: 7,
      feedStatus: 'ausreichend',
      queenColor: 'Blau',
      queenExcluderInserted: true,
      honeySuperCount: 2,
      honeySuperFillLevel: 'ca. 60 Prozent',
      honeyCappingState: 'teilweise verdeckelt',
      honeyWaterContent: 18.2,
      beeEscapeInserted: false,
      varroaTreatmentDone: false,
      varroaTreatment: 'keine Behandlung offen',
      feedingDone: false,
      feedType: 'kein Futter',
      feedAmount: null,
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
      cellsRemoved: true,
      droneFrameFillLevel: 'voll',
      droneFrameRemoved: true,
      droneFrameRenewed: true,
      colonyStrength: 10,
      broodFrameCount: 8,
      feedStatus: 'knapp',
      queenColor: 'Gruen',
      queenExcluderInserted: true,
      honeySuperCount: 2,
      honeySuperFillLevel: 'fast voll',
      honeyCappingState: 'mehrheitlich unverdeckelt',
      honeyWaterContent: 19.1,
      beeEscapeInserted: false,
      varroaTreatmentDone: false,
      varroaTreatment: 'Sommerbehandlung planen',
      feedingDone: false,
      feedType: 'kein Futter',
      feedAmount: null,
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
      cellsRemoved: false,
      droneFrameFillLevel: 'leer',
      droneFrameRemoved: false,
      droneFrameRenewed: false,
      colonyStrength: 5,
      broodFrameCount: 5,
      feedStatus: 'gut',
      queenColor: 'Weiss',
      queenExcluderInserted: false,
      honeySuperCount: 1,
      honeySuperFillLevel: 'gering',
      honeyCappingState: 'kaum verdeckelt',
      honeyWaterContent: null,
      beeEscapeInserted: false,
      varroaTreatmentDone: false,
      varroaTreatment: 'Kontrolle nach Trachtende',
      feedingDone: false,
      feedType: 'kein Futter',
      feedAmount: null,
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
      cellsRemoved: false,
      droneFrameFillLevel: 'angelegt',
      droneFrameRemoved: false,
      droneFrameRenewed: false,
      colonyStrength: 8,
      broodFrameCount: 6,
      feedStatus: 'ausreichend',
      queenColor: 'Blau',
      queenExcluderInserted: true,
      honeySuperCount: 1,
      honeySuperFillLevel: 'halb voll',
      honeyCappingState: 'unverdeckt',
      honeyWaterContent: null,
      beeEscapeInserted: false,
      varroaTreatmentDone: false,
      varroaTreatment: 'keine',
      feedingDone: false,
      feedType: 'kein Futter',
      feedAmount: null,
      notes: 'Honigraum erweitert.',
    ),
    Inspection(
      id: 'inspection-5',
      hiveId: 'hive-5',
      date: DateTime(2026, 5, 29, 15, 20),
      mood: 'ruhig',
      queenSeen: true,
      combPosition: 'mittig',
      queenCellsSeen: false,
      swarmCellsSeen: false,
      emergencyCellsSeen: false,
      cellsRemoved: false,
      droneFrameFillLevel: 'halb gefuellt',
      droneFrameRemoved: false,
      droneFrameRenewed: false,
      colonyStrength: 6,
      broodFrameCount: 5,
      feedStatus: 'gut',
      queenColor: 'Blau',
      queenExcluderInserted: true,
      honeySuperCount: 1,
      honeySuperFillLevel: 'gering',
      honeyCappingState: 'teilweise verdeckelt',
      honeyWaterContent: null,
      beeEscapeInserted: false,
      varroaTreatmentDone: false,
      varroaTreatment: 'keine',
      feedingDone: false,
      feedType: 'kein Futter',
      feedAmount: null,
      notes: 'Volk entwickelt sich gleichmaessig.',
    ),
  ];

  static final List<BeekeeperTask> tasks = [
    BeekeeperTask(
      id: 'task-1',
      title: 'Volk 2 erneut auf Schwarmzellen pruefen',
      description: 'Nach der letzten Kontrolle zeitnah nachsehen.',
      hiveId: 'hive-2',
      category: BeekeeperTaskCategory.inspection,
      dueDate: DateTime(2026, 6, 4),
      dueTime: DateTime(2026, 6, 4, 17, 0),
      status: BeekeeperTaskStatus.open,
      priority: BeekeeperTaskPriority.high,
      createdAt: DateTime(2026, 5, 25, 10, 20),
      completedAt: null,
    ),
    BeekeeperTask(
      id: 'task-2',
      title: 'Futtervorrat bei Ableger 1 kontrollieren',
      description: 'Ableger ist noch schwach, Reserve pruefen.',
      hiveId: 'hive-4',
      category: BeekeeperTaskCategory.feeding,
      dueDate: DateTime(2026, 6, 8),
      dueTime: null,
      status: BeekeeperTaskStatus.open,
      priority: BeekeeperTaskPriority.normal,
      createdAt: DateTime(2026, 6, 1, 14, 0),
      completedAt: null,
    ),
    BeekeeperTask(
      id: 'task-3',
      title: 'Honigraum bei Volk 1 aufsetzen',
      description: 'Erster Honigraum wurde bei der Kontrolle empfohlen.',
      hiveId: 'hive-1',
      category: BeekeeperTaskCategory.honeySuper,
      dueDate: DateTime(2026, 5, 31),
      dueTime: DateTime(2026, 5, 31, 18, 30),
      status: BeekeeperTaskStatus.done,
      priority: BeekeeperTaskPriority.normal,
      createdAt: DateTime(2026, 5, 22, 12, 0),
      completedAt: DateTime(2026, 5, 31, 19, 15),
    ),
    BeekeeperTask(
      id: 'task-4',
      title: 'Bienenflucht bei Volk 1 pruefen',
      description: 'Vor der Honigernte vorbereiten.',
      hiveId: 'hive-1',
      category: BeekeeperTaskCategory.beeEscape,
      dueDate: DateTime(2026, 6, 5),
      dueTime: null,
      status: BeekeeperTaskStatus.open,
      priority: BeekeeperTaskPriority.normal,
      createdAt: DateTime(2026, 6, 2, 12, 10),
      completedAt: null,
    ),
    BeekeeperTask(
      id: 'task-5',
      title: 'Varroa-Plan fuer Volk 3 vorbereiten',
      description: 'Behandlung nach Trachtende planen.',
      hiveId: 'hive-3',
      category: BeekeeperTaskCategory.varroa,
      dueDate: DateTime(2026, 6, 10),
      dueTime: null,
      status: BeekeeperTaskStatus.open,
      priority: BeekeeperTaskPriority.high,
      createdAt: DateTime(2026, 6, 1, 16, 30),
      completedAt: null,
    ),
    BeekeeperTask(
      id: 'task-6',
      title: 'Koeniginnenzeichnung bei Ableger 1 nachtragen',
      description: 'Farbe und Jahr im Volk nachtragen.',
      hiveId: 'hive-4',
      category: BeekeeperTaskCategory.queen,
      dueDate: DateTime(2026, 6, 12),
      dueTime: null,
      status: BeekeeperTaskStatus.open,
      priority: BeekeeperTaskPriority.low,
      createdAt: DateTime(2026, 6, 2, 9, 0),
      completedAt: null,
    ),
  ];

  static BeeStand beeStandById(String id) {
    return beeStands.firstWhere((beeStand) => beeStand.id == id);
  }

  static Hive hiveById(String id) {
    return hives.firstWhere((hive) => hive.id == id);
  }

  static void addInspection(Inspection inspection) {
    inspections.add(inspection);
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

  static BeekeeperTask taskById(String id) {
    return tasks.firstWhere((task) => task.id == id);
  }

  static void addTask(BeekeeperTask task) {
    tasks.add(task);
  }

  static void updateTask(BeekeeperTask updatedTask) {
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index == -1) {
      return;
    }

    tasks[index] = updatedTask;
  }

  static void completeTask(String taskId) {
    final task = taskById(taskId);
    updateTask(
      task.copyWith(
        status: BeekeeperTaskStatus.done,
        completedAt: DateTime.now(),
      ),
    );
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
    final latestInspection = latestInspectionForHive(hiveId);
    final warnings = <String>{};

    if (latestInspection == null ||
        today.difference(latestInspection.date).inDays >= 7) {
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
