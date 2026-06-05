import 'dart:convert';

import 'package:web/web.dart' as web;

import '../demo/demo_data.dart';
import '../models/bee_stand.dart';
import '../models/beekeeper_task.dart';
import '../models/hive.dart';
import '../models/honey_book_entry.dart';
import '../models/inspection.dart';
import '../models/photo_attachment.dart';
import 'app_data_events.dart';

class AppRepositories {
  AppRepositories._()
    : apiaries = WebApiaryRepository._(_WebJsonStore.instance),
      hives = WebHiveRepository._(_WebJsonStore.instance),
      honeyBook = WebHoneyBookRepository._(_WebJsonStore.instance),
      inspections = WebInspectionRepository._(_WebJsonStore.instance),
      photos = WebPhotoAttachmentRepository._(_WebJsonStore.instance),
      tasks = WebTaskRepository._(_WebJsonStore.instance);

  static final AppRepositories instance = AppRepositories._();

  final WebApiaryRepository apiaries;
  final WebHiveRepository hives;
  final WebHoneyBookRepository honeyBook;
  final WebInspectionRepository inspections;
  final WebPhotoAttachmentRepository photos;
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

  Future<List<BeeStand>> listApiaries() {
    return getAll();
  }

  Future<BeeStand> getById(String id) async {
    return _store.apiaries.firstWhere((apiary) => apiary.id == id);
  }

  Future<BeeStand> getApiaryById(String id) {
    return getById(id);
  }

  Future<void> upsert(BeeStand apiary) async {
    final index = _store.apiaries.indexWhere((item) => item.id == apiary.id);
    if (index == -1) {
      _store.apiaries.add(apiary);
    } else {
      _store.apiaries[index] = apiary;
    }
    _store.save();
    AppDataEvents.notifyChanged();
  }

  Future<void> createApiary(BeeStand apiary) {
    return upsert(apiary);
  }

  Future<void> updateApiary(BeeStand apiary) {
    return upsert(apiary);
  }
}

class WebHiveRepository {
  const WebHiveRepository._(this._store);

  final _WebJsonStore _store;

  Future<List<Hive>> getAll() async {
    return _store.hives.map(_withLatestInspectionDate).toList();
  }

  Future<List<Hive>> listHives() {
    return getAll();
  }

  Future<Hive> getById(String id) async {
    final hive = _store.hives.firstWhere((item) => item.id == id);
    return _withLatestInspectionDate(hive);
  }

  Future<Hive> getHiveById(String id) {
    return getById(id);
  }

  Future<void> upsert(Hive hive) async {
    final index = _store.hives.indexWhere((item) => item.id == hive.id);
    if (index == -1) {
      _store.hives.add(hive);
    } else {
      _store.hives[index] = hive;
    }
    _store.save();
    AppDataEvents.notifyChanged();
  }

  Future<void> createHive(Hive hive) {
    return upsert(hive);
  }

  Future<void> updateHive(Hive hive) {
    return upsert(hive);
  }

  Hive _withLatestInspectionDate(Hive hive) {
    final hiveInspections =
        _store.inspections
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

  Future<Inspection> getById(String id) async {
    return _store.inspections.firstWhere((inspection) => inspection.id == id);
  }

  Future<Inspection?> latestForHive(String hiveId) async {
    final inspections = await getForHive(hiveId);
    return inspections.isEmpty ? null : inspections.first;
  }

  Future<Inspection?> getLatestForHive(String hiveId) {
    return latestForHive(hiveId);
  }

  Future<Inspection?> latest() async {
    final inspections = await getAll();
    return inspections.isEmpty ? null : inspections.first;
  }

  Future<void> add(Inspection inspection) {
    return createInspection(inspection);
  }

  Future<void> createInspection(Inspection inspection) {
    return upsert(inspection);
  }

  Future<void> updateInspection(Inspection inspection) {
    return upsert(inspection);
  }

  Future<void> upsert(Inspection inspection) async {
    final index = _store.inspections.indexWhere(
      (item) => item.id == inspection.id,
    );
    if (index == -1) {
      _store.inspections.add(inspection);
    } else {
      _store.inspections[index] = inspection;
    }
    _store.save();
    AppDataEvents.notifyChanged();
  }

  Future<void> deleteInspection(String inspectionId) async {
    _store.inspections.removeWhere(
      (inspection) => inspection.id == inspectionId,
    );
    _store.save();
    AppDataEvents.notifyChanged();
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
    AppDataEvents.notifyChanged();
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

class WebPhotoAttachmentRepository {
  const WebPhotoAttachmentRepository._(this._store);

  final _WebJsonStore _store;

  Future<List<PhotoAttachment>> getForHive(String hiveId) async {
    return _store.photos
        .where(
          (photo) =>
              photo.linkedHiveId == hiveId &&
              photo.type == PhotoAttachmentType.hivePhoto,
        )
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<List<PhotoAttachment>> getForInspection(String inspectionId) async {
    return _store.photos
        .where((photo) => photo.linkedInspectionId == inspectionId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> upsert(PhotoAttachment photo) async {
    final index = _store.photos.indexWhere((item) => item.id == photo.id);
    if (index == -1) {
      _store.photos.add(photo);
    } else {
      _store.photos[index] = photo;
    }
    _store.save();
    AppDataEvents.notifyChanged();
  }

  Future<void> upsertAll(Iterable<PhotoAttachment> photos) async {
    for (final photo in photos) {
      await upsert(photo);
    }
  }

  Future<void> delete(String photoId) async {
    _store.photos.removeWhere((photo) => photo.id == photoId);
    _store.save();
    AppDataEvents.notifyChanged();
  }
}

class WebHoneyBookRepository {
  const WebHoneyBookRepository._(this._store);

  final _WebJsonStore _store;

  Future<List<HoneyBookEntry>> listHoneyBookEntries() async {
    return [..._store.honeyBookEntries]
      ..sort((a, b) => b.harvestDate.compareTo(a.harvestDate));
  }

  Future<HoneyBookEntry> getHoneyBookEntryById(String id) async {
    return _store.honeyBookEntries.firstWhere((entry) => entry.id == id);
  }

  Future<void> createHoneyBookEntry(HoneyBookEntry entry) {
    return upsert(entry);
  }

  Future<void> updateHoneyBookEntry(HoneyBookEntry entry) {
    return upsert(entry);
  }

  Future<void> upsert(HoneyBookEntry entry) async {
    final index = _store.honeyBookEntries.indexWhere(
      (item) => item.id == entry.id,
    );
    if (index == -1) {
      _store.honeyBookEntries.add(entry);
    } else {
      _store.honeyBookEntries[index] = entry;
    }
    _store.save();
    AppDataEvents.notifyChanged();
  }

  Future<void> deleteHoneyBookEntry(String id) async {
    _store.honeyBookEntries.removeWhere((entry) => entry.id == id);
    _store.save();
    AppDataEvents.notifyChanged();
  }
}

class _WebJsonStore {
  _WebJsonStore._();

  static final _WebJsonStore instance = _WebJsonStore._();
  static const _storageKey = 'bienenhalter_app_web_data_v1';

  final List<BeeStand> apiaries = [];
  final List<Hive> hives = [];
  final List<Inspection> inspections = [];
  final List<PhotoAttachment> photos = [];
  final List<HoneyBookEntry> honeyBookEntries = [];
  final List<BeekeeperTask> tasks = [];

  bool _loaded = false;

  void load() {
    if (_loaded) {
      return;
    }

    final rawJson = web.window.localStorage.getItem(_storageKey);
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
    photos
      ..clear()
      ..addAll(
        ((data['photos'] as List<dynamic>?) ?? const []).map(
          (item) => _photoAttachmentFromJson(item as Map<String, dynamic>),
        ),
      );
    honeyBookEntries
      ..clear()
      ..addAll(
        ((data['honeyBookEntries'] as List<dynamic>?) ?? const []).map(
          (item) => _honeyBookEntryFromJson(item as Map<String, dynamic>),
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
      'photos': photos.map(_photoAttachmentToJson).toList(),
      'honeyBookEntries': honeyBookEntries.map(_honeyBookEntryToJson).toList(),
      'tasks': tasks.map(_taskToJson).toList(),
    };
    web.window.localStorage.setItem(_storageKey, jsonEncode(data));
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
    photos.clear();
    honeyBookEntries.clear();
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

  Map<String, dynamic> _photoAttachmentToJson(PhotoAttachment photo) {
    return {
      'id': photo.id,
      'localPath': photo.localPath,
      'filename': photo.filename,
      'linkedHiveId': photo.linkedHiveId,
      'linkedInspectionId': photo.linkedInspectionId,
      'type': photo.type.name,
      'createdAt': photo.createdAt.toIso8601String(),
      'notes': photo.notes,
    };
  }

  PhotoAttachment _photoAttachmentFromJson(Map<String, dynamic> json) {
    return PhotoAttachment(
      id: json['id'] as String,
      localPath: json['localPath'] as String,
      filename: json['filename'] as String,
      linkedHiveId: json['linkedHiveId'] as String?,
      linkedInspectionId: json['linkedInspectionId'] as String?,
      type: PhotoAttachmentType.values.firstWhere(
        (type) => type.name == json['type'],
        orElse: () => PhotoAttachmentType.hivePhoto,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      notes: json['notes'] as String? ?? '',
    );
  }

  Map<String, dynamic> _honeyBookEntryToJson(HoneyBookEntry entry) {
    return {
      'id': entry.id,
      'runningNumber': entry.runningNumber,
      'harvestDate': entry.harvestDate.toIso8601String(),
      'extractionLocation': entry.extractionLocation,
      'honeyType': entry.honeyType,
      'waterContentPercent': entry.waterContentPercent,
      'amountKg': entry.amountKg,
      'bottledAt': entry.bottledAt?.toIso8601String(),
      'labelNumberFrom': entry.labelNumberFrom,
      'labelNumberTo': entry.labelNumberTo,
      'batchNumber': entry.batchNumber,
      'bestBeforeDate': entry.bestBeforeDate?.toIso8601String(),
      'processingType': entry.processingType.name,
      'notes': entry.notes,
      'originNote': entry.originNote,
      'createdAt': entry.createdAt.toIso8601String(),
      'updatedAt': entry.updatedAt.toIso8601String(),
    };
  }

  HoneyBookEntry _honeyBookEntryFromJson(Map<String, dynamic> json) {
    return HoneyBookEntry(
      id: json['id'] as String,
      runningNumber: json['runningNumber'] as String? ?? '',
      harvestDate: DateTime.parse(json['harvestDate'] as String),
      extractionLocation: json['extractionLocation'] as String? ?? '',
      honeyType: json['honeyType'] as String,
      waterContentPercent: (json['waterContentPercent'] as num?)?.toDouble(),
      amountKg: (json['amountKg'] as num).toDouble(),
      bottledAt: json['bottledAt'] == null
          ? null
          : DateTime.parse(json['bottledAt'] as String),
      labelNumberFrom: json['labelNumberFrom'] as String? ?? '',
      labelNumberTo: json['labelNumberTo'] as String? ?? '',
      batchNumber: json['batchNumber'] as String? ?? '',
      bestBeforeDate: json['bestBeforeDate'] == null
          ? null
          : DateTime.parse(json['bestBeforeDate'] as String),
      processingType: HoneyProcessingType.values.firstWhere(
        (type) => type.name == json['processingType'],
        orElse: () => HoneyProcessingType.liquid,
      ),
      notes: json['notes'] as String? ?? '',
      originNote: json['originNote'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
    if (value == 'needsAttention') {
      return HiveStatus.active;
    }
    if (value == 'inactive') {
      return HiveStatus.dissolved;
    }

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
