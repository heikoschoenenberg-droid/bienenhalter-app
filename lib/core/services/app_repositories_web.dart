// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;

import '../demo/demo_data.dart';
import '../models/bee_stand.dart';
import '../models/beekeeper_task.dart';
import '../models/hive.dart';
import '../models/inspection.dart';

class AppRepositories {
  AppRepositories._()
    : apiaries = WebApiaryRepository._(_WebJsonStore.instance),
      hives = WebHiveRepository._(_WebJsonStore.instance),
      inspections = WebInspectionRepository._(_WebJsonStore.instance),
      tasks = WebTaskRepository._(_WebJsonStore.instance);

  static final AppRepositories instance = AppRepositories._();

  final WebApiaryRepository apiaries;
  final WebHiveRepository hives;
  final WebInspectionRepository inspections;
  final WebTaskRepository tasks;

  Future<void> initialize() async {
    _WebJsonStore.instance.load();
  }
}

class WebApiaryRepository {
  const WebApiaryRepository._(this._store);

  final _WebJsonStore _store;

  Future<List<BeeStand>> getAll() async {
    return [..._store.apiaries];
  }

  Future<BeeStand> getById(String id) async {
    return _store.apiaries.firstWhere((apiary) => apiary.id == id);
  }

  Future<void> upsert(BeeStand apiary) async {
    final index = _store.apiaries.indexWhere((item) => item.id == apiary.id);
    if (index == -1) {
      _store.apiaries.add(apiary);
    } else {
      _store.apiaries[index] = apiary;
    }
    _store.save();
  }
}

class WebHiveRepository {
  const WebHiveRepository._(this._store);

  final _WebJsonStore _store;

  Future<List<Hive>> getAll() async {
    return _store.hives.map(_withLatestInspectionDate).toList();
  }

  Future<Hive> getById(String id) async {
    final hive = _store.hives.firstWhere((item) => item.id == id);
    return _withLatestInspectionDate(hive);
  }

  Future<void> upsert(Hive hive) async {
    final index = _store.hives.indexWhere((item) => item.id == hive.id);
    if (index == -1) {
      _store.hives.add(hive);
    } else {
      _store.hives[index] = hive;
    }
    _store.save();
  }

  Hive _withLatestInspectionDate(Hive hive) {
    final hiveInspections = _store.inspections
        .where((inspection) => inspection.hiveId == hive.id)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Hive(
      id: hive.id,
      number: hive.number,
      beeStandId: hive.beeStandId,
      name: hive.name,
      hiveType: hive.hiveType,
      queenYear: hive.queenYear,
      queenColor: hive.queenColor,
      queenOrigin: hive.queenOrigin,
      status: hive.status,
      notes: hive.notes,
      createdAt: hive.createdAt,
      updatedAt: hive.updatedAt,
      lastInspectionDate: hiveInspections.isEmpty
          ? hive.lastInspectionDate
          : hiveInspections.first.date,
    );
  }
}

class WebInspectionRepository {
  const WebInspectionRepository._(this._store);

  final _WebJsonStore _store;

  Future<List<Inspection>> getAll() async {
    return [..._store.inspections]..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<List<Inspection>> getForHive(String hiveId) async {
    return _store.inspections.where((item) => item.hiveId == hiveId).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<Inspection?> latestForHive(String hiveId) async {
    final inspections = await getForHive(hiveId);
    return inspections.isEmpty ? null : inspections.first;
  }

  Future<Inspection?> latest() async {
    final inspections = await getAll();
    return inspections.isEmpty ? null : inspections.first;
  }

  Future<void> add(Inspection inspection) async {
    _store.inspections.add(inspection);
    _store.save();
  }
}

class WebTaskRepository {
  const WebTaskRepository._(this._store);

  final _WebJsonStore _store;

  Future<List<BeekeeperTask>> getAllSorted() async {
    final tasks = [..._store.tasks]
      ..sort((a, b) {
        if (a.isOpen != b.isOpen) {
          return a.isOpen ? -1 : 1;
        }
        return a.dueDate.compareTo(b.dueDate);
      });
    return tasks;
  }

  Future<List<BeekeeperTask>> getOpenForHive(String hiveId) async {
    return _store.tasks
        .where((task) => task.hiveId == hiveId && task.isOpen)
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  Future<BeekeeperTask> getById(String id) async {
    return _store.tasks.firstWhere((task) => task.id == id);
  }

  Future<void> upsert(BeekeeperTask task) async {
    final index = _store.tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) {
      _store.tasks.add(task);
    } else {
      _store.tasks[index] = task;
    }
    _store.save();
  }

  Future<void> complete(String taskId) async {
    final task = await getById(taskId);
    await upsert(
      task.copyWith(
        status: BeekeeperTaskStatus.done,
        completedAt: DateTime.now(),
      ),
    );
  }
}

class _WebJsonStore {
  _WebJsonStore._();

  static final _WebJsonStore instance = _WebJsonStore._();
  static const _storageKey = 'bienenhalter_app_web_data_v1';

  final List<BeeStand> apiaries = [];
  final List<Hive> hives = [];
  final List<Inspection> inspections = [];
  final List<BeekeeperTask> tasks = [];

  bool _loaded = false;

  void load() {
    if (_loaded) {
      return;
    }

    final rawJson = html.window.localStorage[_storageKey];
    if (rawJson == null || rawJson.isEmpty) {
      _seedFromDemoData();
      save();
      _loaded = true;
      return;
    }

    final data = jsonDecode(rawJson) as Map<String, dynamic>;
    apiaries
      ..clear()
      ..addAll(
        (data['apiaries'] as List<dynamic>).map(
          (item) => _beeStandFromJson(item as Map<String, dynamic>),
        ),
      );
    hives
      ..clear()
      ..addAll(
        (data['hives'] as List<dynamic>).map(
          (item) => _hiveFromJson(item as Map<String, dynamic>),
        ),
      );
    inspections
      ..clear()
      ..addAll(
        (data['inspections'] as List<dynamic>).map(
          (item) => _inspectionFromJson(item as Map<String, dynamic>),
        ),
      );
    tasks
      ..clear()
      ..addAll(
        (data['tasks'] as List<dynamic>).map(
          (item) => _taskFromJson(item as Map<String, dynamic>),
        ),
      );
    _loaded = true;
  }

  void save() {
    final data = {
      'apiaries': apiaries.map(_beeStandToJson).toList(),
      'hives': hives.map(_hiveToJson).toList(),
      'inspections': inspections.map(_inspectionToJson).toList(),
      'tasks': tasks.map(_taskToJson).toList(),
    };
    html.window.localStorage[_storageKey] = jsonEncode(data);
  }

  void _seedFromDemoData() {
    apiaries
      ..clear()
      ..addAll(DemoData.beeStands);
    hives
      ..clear()
      ..addAll(DemoData.hives);
    inspections
      ..clear()
      ..addAll(DemoData.inspections);
    tasks
      ..clear()
      ..addAll(DemoData.tasks);
  }

  Map<String, dynamic> _beeStandToJson(BeeStand apiary) {
    return {
      'id': apiary.id,
      'name': apiary.name,
      'location': apiary.location,
      'notes': apiary.notes,
      'createdAt': apiary.createdAt.toIso8601String(),
      'updatedAt': apiary.updatedAt.toIso8601String(),
    };
  }

  BeeStand _beeStandFromJson(Map<String, dynamic> json) {
    return BeeStand(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      notes: json['notes'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> _hiveToJson(Hive hive) {
    return {
      'id': hive.id,
      'number': hive.number,
      'beeStandId': hive.beeStandId,
      'name': hive.name,
      'hiveType': hive.hiveType,
      'queenYear': hive.queenYear,
      'queenColor': hive.queenColor,
      'queenOrigin': hive.queenOrigin,
      'status': hive.status.name,
      'notes': hive.notes,
      'createdAt': hive.createdAt.toIso8601String(),
      'updatedAt': hive.updatedAt.toIso8601String(),
      'lastInspectionDate': hive.lastInspectionDate?.toIso8601String(),
    };
  }

  Hive _hiveFromJson(Map<String, dynamic> json) {
    return Hive(
      id: json['id'] as String,
      number: json['number'] as String,
      beeStandId: json['beeStandId'] as String,
      name: json['name'] as String? ?? '',
      hiveType: json['hiveType'] as String? ?? 'Magazin',
      queenYear: json['queenYear'] as int,
      queenColor: json['queenColor'] as String,
      queenOrigin: json['queenOrigin'] as String? ?? 'unbekannt',
      status: _hiveStatusFromName(json['status'] as String),
      notes: json['notes'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lastInspectionDate: json['lastInspectionDate'] == null
          ? null
          : DateTime.parse(json['lastInspectionDate'] as String),
    );
  }

  Map<String, dynamic> _inspectionToJson(Inspection inspection) {
    return {
      'id': inspection.id,
      'hiveId': inspection.hiveId,
      'date': inspection.date.toIso8601String(),
      'mood': inspection.mood,
      'queenSeen': inspection.queenSeen,
      'combPosition': inspection.combPosition,
      'queenCellsSeen': inspection.queenCellsSeen,
      'swarmCellsSeen': inspection.swarmCellsSeen,
      'emergencyCellsSeen': inspection.emergencyCellsSeen,
      'cellsRemoved': inspection.cellsRemoved,
      'droneFrameFillLevel': inspection.droneFrameFillLevel,
      'droneFrameRemoved': inspection.droneFrameRemoved,
      'droneFrameRenewed': inspection.droneFrameRenewed,
      'colonyStrength': inspection.colonyStrength,
      'broodFrameCount': inspection.broodFrameCount,
      'feedStatus': inspection.feedStatus,
      'queenColor': inspection.queenColor,
      'queenExcluderInserted': inspection.queenExcluderInserted,
      'honeySuperCount': inspection.honeySuperCount,
      'honeySuperFillLevel': inspection.honeySuperFillLevel,
      'honeyCappingState': inspection.honeyCappingState,
      'honeyWaterContent': inspection.honeyWaterContent,
      'beeEscapeInserted': inspection.beeEscapeInserted,
      'varroaTreatmentDone': inspection.varroaTreatmentDone,
      'varroaTreatment': inspection.varroaTreatment,
      'feedingDone': inspection.feedingDone,
      'feedType': inspection.feedType,
      'feedAmount': inspection.feedAmount,
      'notes': inspection.notes,
    };
  }

  Inspection _inspectionFromJson(Map<String, dynamic> json) {
    return Inspection(
      id: json['id'] as String,
      hiveId: json['hiveId'] as String,
      date: DateTime.parse(json['date'] as String),
      mood: json['mood'] as String,
      queenSeen: json['queenSeen'] as bool,
      combPosition: json['combPosition'] as String,
      queenCellsSeen: json['queenCellsSeen'] as bool,
      swarmCellsSeen: json['swarmCellsSeen'] as bool,
      emergencyCellsSeen: json['emergencyCellsSeen'] as bool,
      cellsRemoved: json['cellsRemoved'] as bool,
      droneFrameFillLevel: json['droneFrameFillLevel'] as String,
      droneFrameRemoved: json['droneFrameRemoved'] as bool,
      droneFrameRenewed: json['droneFrameRenewed'] as bool,
      colonyStrength: json['colonyStrength'] as int,
      broodFrameCount: json['broodFrameCount'] as int,
      feedStatus: json['feedStatus'] as String,
      queenColor: json['queenColor'] as String,
      queenExcluderInserted: json['queenExcluderInserted'] as bool,
      honeySuperCount: json['honeySuperCount'] as int,
      honeySuperFillLevel: json['honeySuperFillLevel'] as String,
      honeyCappingState: json['honeyCappingState'] as String,
      honeyWaterContent: (json['honeyWaterContent'] as num?)?.toDouble(),
      beeEscapeInserted: json['beeEscapeInserted'] as bool,
      varroaTreatmentDone: json['varroaTreatmentDone'] as bool,
      varroaTreatment: json['varroaTreatment'] as String,
      feedingDone: json['feedingDone'] as bool,
      feedType: json['feedType'] as String,
      feedAmount: (json['feedAmount'] as num?)?.toDouble(),
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> _taskToJson(BeekeeperTask task) {
    return {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'hiveId': task.hiveId,
      'category': task.category.name,
      'dueDate': task.dueDate.toIso8601String(),
      'dueTime': task.dueTime?.toIso8601String(),
      'status': task.status.name,
      'priority': task.priority.name,
      'createdAt': task.createdAt.toIso8601String(),
      'completedAt': task.completedAt?.toIso8601String(),
    };
  }

  BeekeeperTask _taskFromJson(Map<String, dynamic> json) {
    return BeekeeperTask(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      hiveId: json['hiveId'] as String,
      category: _taskCategoryFromName(json['category'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      dueTime: json['dueTime'] == null
          ? null
          : DateTime.parse(json['dueTime'] as String),
      status: _taskStatusFromName(json['status'] as String),
      priority: _taskPriorityFromName(json['priority'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );
  }

  HiveStatus _hiveStatusFromName(String value) {
    return HiveStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => HiveStatus.active,
    );
  }

  BeekeeperTaskCategory _taskCategoryFromName(String value) {
    return BeekeeperTaskCategory.values.firstWhere(
      (category) => category.name == value,
      orElse: () => BeekeeperTaskCategory.other,
    );
  }

  BeekeeperTaskPriority _taskPriorityFromName(String value) {
    return BeekeeperTaskPriority.values.firstWhere(
      (priority) => priority.name == value,
      orElse: () => BeekeeperTaskPriority.normal,
    );
  }

  BeekeeperTaskStatus _taskStatusFromName(String value) {
    return BeekeeperTaskStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => BeekeeperTaskStatus.open,
    );
  }
}
