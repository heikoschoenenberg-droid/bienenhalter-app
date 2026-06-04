import 'package:bienenhalter_app/core/database/app_database.dart'
    hide Inspection;
import 'package:bienenhalter_app/core/models/beekeeper_task.dart';
import 'package:bienenhalter_app/core/models/inspection.dart';
import 'package:bienenhalter_app/core/repositories/apiary_repository.dart';
import 'package:bienenhalter_app/core/repositories/hive_repository.dart';
import 'package:bienenhalter_app/core/repositories/inspection_repository.dart';
import 'package:bienenhalter_app/core/repositories/task_repository.dart';
import 'package:bienenhalter_app/core/seed/database_seed.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late ApiaryRepository apiaries;
  late HiveRepository hives;
  late InspectionRepository inspections;
  late TaskRepository tasks;

  setUp(() async {
    database = AppDatabase.forExecutor(NativeDatabase.memory());
    apiaries = ApiaryRepository(database);
    hives = HiveRepository(database);
    inspections = InspectionRepository(database);
    tasks = TaskRepository(database);

    await DatabaseSeed(
      database: database,
      apiaryRepository: apiaries,
      hiveRepository: hives,
      inspectionRepository: inspections,
      taskRepository: tasks,
    ).seedIfEmpty();
  });

  tearDown(() async {
    await database.close();
  });

  test('repository can load seeded hives', () async {
    final seededHives = await hives.getAll();

    expect(seededHives.length, greaterThanOrEqualTo(5));
  });

  test('task can be created and completed', () async {
    final hive = (await hives.getAll()).first;
    final task = BeekeeperTask(
      id: 'test-task',
      title: 'Testaufgabe',
      description: 'Beschreibung',
      hiveId: hive.id,
      category: BeekeeperTaskCategory.other,
      dueDate: DateTime(2026, 6, 20),
      dueTime: null,
      status: BeekeeperTaskStatus.open,
      priority: BeekeeperTaskPriority.normal,
      createdAt: DateTime(2026, 6, 4),
      completedAt: null,
    );

    await tasks.upsert(task);
    await tasks.complete(task.id);

    final completedTask = await tasks.getById(task.id);
    expect(completedTask.status, BeekeeperTaskStatus.done);
    expect(completedTask.completedAt, isNotNull);
  });

  test('inspection can be created', () async {
    final hive = (await hives.getAll()).first;
    final inspection = Inspection(
      id: 'test-inspection',
      hiveId: hive.id,
      date: DateTime(2026, 6, 20, 10),
      mood: 'ruhig',
      queenSeen: true,
      combPosition: 'mittig',
      queenCellsSeen: false,
      swarmCellsSeen: false,
      emergencyCellsSeen: false,
      cellsRemoved: false,
      droneFrameFillLevel: 'leer',
      droneFrameRemoved: false,
      droneFrameRenewed: false,
      colonyStrength: 6,
      broodFrameCount: 5,
      feedStatus: 'ausreichend',
      queenColor: 'Blau',
      queenExcluderInserted: true,
      honeySuperCount: 1,
      honeySuperFillLevel: 'gering',
      honeyCappingState: 'unverdeckt',
      honeyWaterContent: null,
      beeEscapeInserted: false,
      varroaTreatmentDone: false,
      varroaTreatment: 'keine',
      feedingDone: false,
      feedType: 'kein Futter',
      feedAmount: null,
      notes: 'Testkontrolle',
    );

    await inspections.add(inspection);

    final hiveInspections = await inspections.getForHive(hive.id);
    expect(hiveInspections.any((item) => item.id == inspection.id), isTrue);
  });
}
