// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ApiariesTable extends Apiaries with TableInfo<$ApiariesTable, Apiary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApiariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    location,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'apiaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Apiary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Apiary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Apiary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ApiariesTable createAlias(String alias) {
    return $ApiariesTable(attachedDatabase, alias);
  }
}

class Apiary extends DataClass implements Insertable<Apiary> {
  final String id;
  final String name;
  final String location;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Apiary({
    required this.id,
    required this.name,
    required this.location,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['location'] = Variable<String>(location);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ApiariesCompanion toCompanion(bool nullToAbsent) {
    return ApiariesCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Apiary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Apiary(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String>(json['location']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String>(location),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Apiary copyWith({
    String? id,
    String? name,
    String? location,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Apiary(
    id: id ?? this.id,
    name: name ?? this.name,
    location: location ?? this.location,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Apiary copyWithCompanion(ApiariesCompanion data) {
    return Apiary(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Apiary(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, location, notes, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Apiary &&
          other.id == this.id &&
          other.name == this.name &&
          other.location == this.location &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ApiariesCompanion extends UpdateCompanion<Apiary> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> location;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ApiariesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApiariesCompanion.insert({
    required String id,
    required String name,
    required String location,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       location = Value(location),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Apiary> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? location,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApiariesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? location,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ApiariesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApiariesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HivesTable extends Hives with TableInfo<$HivesTable, Hive> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HivesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apiaryIdMeta = const VerificationMeta(
    'apiaryId',
  );
  @override
  late final GeneratedColumn<String> apiaryId = GeneratedColumn<String>(
    'apiary_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES apiaries(id)',
  );
  static const VerificationMeta _hiveNumberMeta = const VerificationMeta(
    'hiveNumber',
  );
  @override
  late final GeneratedColumn<String> hiveNumber = GeneratedColumn<String>(
    'hive_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _hiveTypeMeta = const VerificationMeta(
    'hiveType',
  );
  @override
  late final GeneratedColumn<String> hiveType = GeneratedColumn<String>(
    'hive_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Magazin'),
  );
  static const VerificationMeta _queenYearMeta = const VerificationMeta(
    'queenYear',
  );
  @override
  late final GeneratedColumn<int> queenYear = GeneratedColumn<int>(
    'queen_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queenColorMeta = const VerificationMeta(
    'queenColor',
  );
  @override
  late final GeneratedColumn<String> queenColor = GeneratedColumn<String>(
    'queen_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queenOriginMeta = const VerificationMeta(
    'queenOrigin',
  );
  @override
  late final GeneratedColumn<String> queenOrigin = GeneratedColumn<String>(
    'queen_origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unbekannt'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    apiaryId,
    hiveNumber,
    name,
    hiveType,
    queenYear,
    queenColor,
    queenOrigin,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hives';
  @override
  VerificationContext validateIntegrity(
    Insertable<Hive> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('apiary_id')) {
      context.handle(
        _apiaryIdMeta,
        apiaryId.isAcceptableOrUnknown(data['apiary_id']!, _apiaryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_apiaryIdMeta);
    }
    if (data.containsKey('hive_number')) {
      context.handle(
        _hiveNumberMeta,
        hiveNumber.isAcceptableOrUnknown(data['hive_number']!, _hiveNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_hiveNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('hive_type')) {
      context.handle(
        _hiveTypeMeta,
        hiveType.isAcceptableOrUnknown(data['hive_type']!, _hiveTypeMeta),
      );
    }
    if (data.containsKey('queen_year')) {
      context.handle(
        _queenYearMeta,
        queenYear.isAcceptableOrUnknown(data['queen_year']!, _queenYearMeta),
      );
    } else if (isInserting) {
      context.missing(_queenYearMeta);
    }
    if (data.containsKey('queen_color')) {
      context.handle(
        _queenColorMeta,
        queenColor.isAcceptableOrUnknown(data['queen_color']!, _queenColorMeta),
      );
    } else if (isInserting) {
      context.missing(_queenColorMeta);
    }
    if (data.containsKey('queen_origin')) {
      context.handle(
        _queenOriginMeta,
        queenOrigin.isAcceptableOrUnknown(
          data['queen_origin']!,
          _queenOriginMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hive map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hive(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      apiaryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apiary_id'],
      )!,
      hiveNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hive_number'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      hiveType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hive_type'],
      )!,
      queenYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}queen_year'],
      )!,
      queenColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queen_color'],
      )!,
      queenOrigin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queen_origin'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HivesTable createAlias(String alias) {
    return $HivesTable(attachedDatabase, alias);
  }
}

class Hive extends DataClass implements Insertable<Hive> {
  final String id;
  final String apiaryId;
  final String hiveNumber;
  final String name;
  final String hiveType;
  final int queenYear;
  final String queenColor;
  final String queenOrigin;
  final String status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Hive({
    required this.id,
    required this.apiaryId,
    required this.hiveNumber,
    required this.name,
    required this.hiveType,
    required this.queenYear,
    required this.queenColor,
    required this.queenOrigin,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['apiary_id'] = Variable<String>(apiaryId);
    map['hive_number'] = Variable<String>(hiveNumber);
    map['name'] = Variable<String>(name);
    map['hive_type'] = Variable<String>(hiveType);
    map['queen_year'] = Variable<int>(queenYear);
    map['queen_color'] = Variable<String>(queenColor);
    map['queen_origin'] = Variable<String>(queenOrigin);
    map['status'] = Variable<String>(status);
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HivesCompanion toCompanion(bool nullToAbsent) {
    return HivesCompanion(
      id: Value(id),
      apiaryId: Value(apiaryId),
      hiveNumber: Value(hiveNumber),
      name: Value(name),
      hiveType: Value(hiveType),
      queenYear: Value(queenYear),
      queenColor: Value(queenColor),
      queenOrigin: Value(queenOrigin),
      status: Value(status),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Hive.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hive(
      id: serializer.fromJson<String>(json['id']),
      apiaryId: serializer.fromJson<String>(json['apiaryId']),
      hiveNumber: serializer.fromJson<String>(json['hiveNumber']),
      name: serializer.fromJson<String>(json['name']),
      hiveType: serializer.fromJson<String>(json['hiveType']),
      queenYear: serializer.fromJson<int>(json['queenYear']),
      queenColor: serializer.fromJson<String>(json['queenColor']),
      queenOrigin: serializer.fromJson<String>(json['queenOrigin']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'apiaryId': serializer.toJson<String>(apiaryId),
      'hiveNumber': serializer.toJson<String>(hiveNumber),
      'name': serializer.toJson<String>(name),
      'hiveType': serializer.toJson<String>(hiveType),
      'queenYear': serializer.toJson<int>(queenYear),
      'queenColor': serializer.toJson<String>(queenColor),
      'queenOrigin': serializer.toJson<String>(queenOrigin),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Hive copyWith({
    String? id,
    String? apiaryId,
    String? hiveNumber,
    String? name,
    String? hiveType,
    int? queenYear,
    String? queenColor,
    String? queenOrigin,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Hive(
    id: id ?? this.id,
    apiaryId: apiaryId ?? this.apiaryId,
    hiveNumber: hiveNumber ?? this.hiveNumber,
    name: name ?? this.name,
    hiveType: hiveType ?? this.hiveType,
    queenYear: queenYear ?? this.queenYear,
    queenColor: queenColor ?? this.queenColor,
    queenOrigin: queenOrigin ?? this.queenOrigin,
    status: status ?? this.status,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Hive copyWithCompanion(HivesCompanion data) {
    return Hive(
      id: data.id.present ? data.id.value : this.id,
      apiaryId: data.apiaryId.present ? data.apiaryId.value : this.apiaryId,
      hiveNumber: data.hiveNumber.present
          ? data.hiveNumber.value
          : this.hiveNumber,
      name: data.name.present ? data.name.value : this.name,
      hiveType: data.hiveType.present ? data.hiveType.value : this.hiveType,
      queenYear: data.queenYear.present ? data.queenYear.value : this.queenYear,
      queenColor: data.queenColor.present
          ? data.queenColor.value
          : this.queenColor,
      queenOrigin: data.queenOrigin.present
          ? data.queenOrigin.value
          : this.queenOrigin,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hive(')
          ..write('id: $id, ')
          ..write('apiaryId: $apiaryId, ')
          ..write('hiveNumber: $hiveNumber, ')
          ..write('name: $name, ')
          ..write('hiveType: $hiveType, ')
          ..write('queenYear: $queenYear, ')
          ..write('queenColor: $queenColor, ')
          ..write('queenOrigin: $queenOrigin, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    apiaryId,
    hiveNumber,
    name,
    hiveType,
    queenYear,
    queenColor,
    queenOrigin,
    status,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hive &&
          other.id == this.id &&
          other.apiaryId == this.apiaryId &&
          other.hiveNumber == this.hiveNumber &&
          other.name == this.name &&
          other.hiveType == this.hiveType &&
          other.queenYear == this.queenYear &&
          other.queenColor == this.queenColor &&
          other.queenOrigin == this.queenOrigin &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HivesCompanion extends UpdateCompanion<Hive> {
  final Value<String> id;
  final Value<String> apiaryId;
  final Value<String> hiveNumber;
  final Value<String> name;
  final Value<String> hiveType;
  final Value<int> queenYear;
  final Value<String> queenColor;
  final Value<String> queenOrigin;
  final Value<String> status;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HivesCompanion({
    this.id = const Value.absent(),
    this.apiaryId = const Value.absent(),
    this.hiveNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.hiveType = const Value.absent(),
    this.queenYear = const Value.absent(),
    this.queenColor = const Value.absent(),
    this.queenOrigin = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HivesCompanion.insert({
    required String id,
    required String apiaryId,
    required String hiveNumber,
    this.name = const Value.absent(),
    this.hiveType = const Value.absent(),
    required int queenYear,
    required String queenColor,
    this.queenOrigin = const Value.absent(),
    required String status,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       apiaryId = Value(apiaryId),
       hiveNumber = Value(hiveNumber),
       queenYear = Value(queenYear),
       queenColor = Value(queenColor),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Hive> custom({
    Expression<String>? id,
    Expression<String>? apiaryId,
    Expression<String>? hiveNumber,
    Expression<String>? name,
    Expression<String>? hiveType,
    Expression<int>? queenYear,
    Expression<String>? queenColor,
    Expression<String>? queenOrigin,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (apiaryId != null) 'apiary_id': apiaryId,
      if (hiveNumber != null) 'hive_number': hiveNumber,
      if (name != null) 'name': name,
      if (hiveType != null) 'hive_type': hiveType,
      if (queenYear != null) 'queen_year': queenYear,
      if (queenColor != null) 'queen_color': queenColor,
      if (queenOrigin != null) 'queen_origin': queenOrigin,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HivesCompanion copyWith({
    Value<String>? id,
    Value<String>? apiaryId,
    Value<String>? hiveNumber,
    Value<String>? name,
    Value<String>? hiveType,
    Value<int>? queenYear,
    Value<String>? queenColor,
    Value<String>? queenOrigin,
    Value<String>? status,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HivesCompanion(
      id: id ?? this.id,
      apiaryId: apiaryId ?? this.apiaryId,
      hiveNumber: hiveNumber ?? this.hiveNumber,
      name: name ?? this.name,
      hiveType: hiveType ?? this.hiveType,
      queenYear: queenYear ?? this.queenYear,
      queenColor: queenColor ?? this.queenColor,
      queenOrigin: queenOrigin ?? this.queenOrigin,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (apiaryId.present) {
      map['apiary_id'] = Variable<String>(apiaryId.value);
    }
    if (hiveNumber.present) {
      map['hive_number'] = Variable<String>(hiveNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hiveType.present) {
      map['hive_type'] = Variable<String>(hiveType.value);
    }
    if (queenYear.present) {
      map['queen_year'] = Variable<int>(queenYear.value);
    }
    if (queenColor.present) {
      map['queen_color'] = Variable<String>(queenColor.value);
    }
    if (queenOrigin.present) {
      map['queen_origin'] = Variable<String>(queenOrigin.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HivesCompanion(')
          ..write('id: $id, ')
          ..write('apiaryId: $apiaryId, ')
          ..write('hiveNumber: $hiveNumber, ')
          ..write('name: $name, ')
          ..write('hiveType: $hiveType, ')
          ..write('queenYear: $queenYear, ')
          ..write('queenColor: $queenColor, ')
          ..write('queenOrigin: $queenOrigin, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InspectionsTable extends Inspections
    with TableInfo<$InspectionsTable, Inspection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hiveIdMeta = const VerificationMeta('hiveId');
  @override
  late final GeneratedColumn<String> hiveId = GeneratedColumn<String>(
    'hive_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES hives(id)',
  );
  static const VerificationMeta _inspectionDateTimeMeta =
      const VerificationMeta('inspectionDateTime');
  @override
  late final GeneratedColumn<DateTime> inspectionDateTime =
      GeneratedColumn<DateTime>(
        'inspection_date_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queenSeenMeta = const VerificationMeta(
    'queenSeen',
  );
  @override
  late final GeneratedColumn<bool> queenSeen = GeneratedColumn<bool>(
    'queen_seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("queen_seen" IN (0, 1))',
    ),
  );
  static const VerificationMeta _combPositionMeta = const VerificationMeta(
    'combPosition',
  );
  @override
  late final GeneratedColumn<String> combPosition = GeneratedColumn<String>(
    'comb_position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queenCellsSeenMeta = const VerificationMeta(
    'queenCellsSeen',
  );
  @override
  late final GeneratedColumn<bool> queenCellsSeen = GeneratedColumn<bool>(
    'queen_cells_seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("queen_cells_seen" IN (0, 1))',
    ),
  );
  static const VerificationMeta _swarmCellsSeenMeta = const VerificationMeta(
    'swarmCellsSeen',
  );
  @override
  late final GeneratedColumn<bool> swarmCellsSeen = GeneratedColumn<bool>(
    'swarm_cells_seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("swarm_cells_seen" IN (0, 1))',
    ),
  );
  static const VerificationMeta _emergencyCellsSeenMeta =
      const VerificationMeta('emergencyCellsSeen');
  @override
  late final GeneratedColumn<bool> emergencyCellsSeen = GeneratedColumn<bool>(
    'emergency_cells_seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("emergency_cells_seen" IN (0, 1))',
    ),
  );
  static const VerificationMeta _cellsRemovedMeta = const VerificationMeta(
    'cellsRemoved',
  );
  @override
  late final GeneratedColumn<bool> cellsRemoved = GeneratedColumn<bool>(
    'cells_removed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cells_removed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _droneFrameFillLevelMeta =
      const VerificationMeta('droneFrameFillLevel');
  @override
  late final GeneratedColumn<String> droneFrameFillLevel =
      GeneratedColumn<String>(
        'drone_frame_fill_level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _droneFrameRemovedMeta = const VerificationMeta(
    'droneFrameRemoved',
  );
  @override
  late final GeneratedColumn<bool> droneFrameRemoved = GeneratedColumn<bool>(
    'drone_frame_removed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("drone_frame_removed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _droneFrameRenewedMeta = const VerificationMeta(
    'droneFrameRenewed',
  );
  @override
  late final GeneratedColumn<bool> droneFrameRenewed = GeneratedColumn<bool>(
    'drone_frame_renewed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("drone_frame_renewed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _colonyStrengthMeta = const VerificationMeta(
    'colonyStrength',
  );
  @override
  late final GeneratedColumn<int> colonyStrength = GeneratedColumn<int>(
    'colony_strength',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _broodFramesMeta = const VerificationMeta(
    'broodFrames',
  );
  @override
  late final GeneratedColumn<int> broodFrames = GeneratedColumn<int>(
    'brood_frames',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodStatusMeta = const VerificationMeta(
    'foodStatus',
  );
  @override
  late final GeneratedColumn<String> foodStatus = GeneratedColumn<String>(
    'food_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queenColorMeta = const VerificationMeta(
    'queenColor',
  );
  @override
  late final GeneratedColumn<String> queenColor = GeneratedColumn<String>(
    'queen_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _queenExcluderInsertedMeta =
      const VerificationMeta('queenExcluderInserted');
  @override
  late final GeneratedColumn<bool> queenExcluderInserted =
      GeneratedColumn<bool>(
        'queen_excluder_inserted',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("queen_excluder_inserted" IN (0, 1))',
        ),
      );
  static const VerificationMeta _honeySupersCountMeta = const VerificationMeta(
    'honeySupersCount',
  );
  @override
  late final GeneratedColumn<int> honeySupersCount = GeneratedColumn<int>(
    'honey_supers_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _honeySuperFillLevelMeta =
      const VerificationMeta('honeySuperFillLevel');
  @override
  late final GeneratedColumn<String> honeySuperFillLevel =
      GeneratedColumn<String>(
        'honey_super_fill_level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _honeyCappingStatusMeta =
      const VerificationMeta('honeyCappingStatus');
  @override
  late final GeneratedColumn<String> honeyCappingStatus =
      GeneratedColumn<String>(
        'honey_capping_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _honeyWaterContentMeta = const VerificationMeta(
    'honeyWaterContent',
  );
  @override
  late final GeneratedColumn<double> honeyWaterContent =
      GeneratedColumn<double>(
        'honey_water_content',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _beeEscapeInsertedMeta = const VerificationMeta(
    'beeEscapeInserted',
  );
  @override
  late final GeneratedColumn<bool> beeEscapeInserted = GeneratedColumn<bool>(
    'bee_escape_inserted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bee_escape_inserted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _varroaTreatmentDoneMeta =
      const VerificationMeta('varroaTreatmentDone');
  @override
  late final GeneratedColumn<bool> varroaTreatmentDone = GeneratedColumn<bool>(
    'varroa_treatment_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("varroa_treatment_done" IN (0, 1))',
    ),
  );
  static const VerificationMeta _varroaTreatmentTypeMeta =
      const VerificationMeta('varroaTreatmentType');
  @override
  late final GeneratedColumn<String> varroaTreatmentType =
      GeneratedColumn<String>(
        'varroa_treatment_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _feedingDoneMeta = const VerificationMeta(
    'feedingDone',
  );
  @override
  late final GeneratedColumn<bool> feedingDone = GeneratedColumn<bool>(
    'feeding_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("feeding_done" IN (0, 1))',
    ),
  );
  static const VerificationMeta _feedingTypeMeta = const VerificationMeta(
    'feedingType',
  );
  @override
  late final GeneratedColumn<String> feedingType = GeneratedColumn<String>(
    'feeding_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedingAmountMeta = const VerificationMeta(
    'feedingAmount',
  );
  @override
  late final GeneratedColumn<double> feedingAmount = GeneratedColumn<double>(
    'feeding_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hiveId,
    inspectionDateTime,
    mood,
    queenSeen,
    combPosition,
    queenCellsSeen,
    swarmCellsSeen,
    emergencyCellsSeen,
    cellsRemoved,
    droneFrameFillLevel,
    droneFrameRemoved,
    droneFrameRenewed,
    colonyStrength,
    broodFrames,
    foodStatus,
    queenColor,
    queenExcluderInserted,
    honeySupersCount,
    honeySuperFillLevel,
    honeyCappingStatus,
    honeyWaterContent,
    beeEscapeInserted,
    varroaTreatmentDone,
    varroaTreatmentType,
    feedingDone,
    feedingType,
    feedingAmount,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspections';
  @override
  VerificationContext validateIntegrity(
    Insertable<Inspection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hive_id')) {
      context.handle(
        _hiveIdMeta,
        hiveId.isAcceptableOrUnknown(data['hive_id']!, _hiveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_hiveIdMeta);
    }
    if (data.containsKey('inspection_date_time')) {
      context.handle(
        _inspectionDateTimeMeta,
        inspectionDateTime.isAcceptableOrUnknown(
          data['inspection_date_time']!,
          _inspectionDateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionDateTimeMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    } else if (isInserting) {
      context.missing(_moodMeta);
    }
    if (data.containsKey('queen_seen')) {
      context.handle(
        _queenSeenMeta,
        queenSeen.isAcceptableOrUnknown(data['queen_seen']!, _queenSeenMeta),
      );
    } else if (isInserting) {
      context.missing(_queenSeenMeta);
    }
    if (data.containsKey('comb_position')) {
      context.handle(
        _combPositionMeta,
        combPosition.isAcceptableOrUnknown(
          data['comb_position']!,
          _combPositionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_combPositionMeta);
    }
    if (data.containsKey('queen_cells_seen')) {
      context.handle(
        _queenCellsSeenMeta,
        queenCellsSeen.isAcceptableOrUnknown(
          data['queen_cells_seen']!,
          _queenCellsSeenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_queenCellsSeenMeta);
    }
    if (data.containsKey('swarm_cells_seen')) {
      context.handle(
        _swarmCellsSeenMeta,
        swarmCellsSeen.isAcceptableOrUnknown(
          data['swarm_cells_seen']!,
          _swarmCellsSeenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_swarmCellsSeenMeta);
    }
    if (data.containsKey('emergency_cells_seen')) {
      context.handle(
        _emergencyCellsSeenMeta,
        emergencyCellsSeen.isAcceptableOrUnknown(
          data['emergency_cells_seen']!,
          _emergencyCellsSeenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emergencyCellsSeenMeta);
    }
    if (data.containsKey('cells_removed')) {
      context.handle(
        _cellsRemovedMeta,
        cellsRemoved.isAcceptableOrUnknown(
          data['cells_removed']!,
          _cellsRemovedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cellsRemovedMeta);
    }
    if (data.containsKey('drone_frame_fill_level')) {
      context.handle(
        _droneFrameFillLevelMeta,
        droneFrameFillLevel.isAcceptableOrUnknown(
          data['drone_frame_fill_level']!,
          _droneFrameFillLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_droneFrameFillLevelMeta);
    }
    if (data.containsKey('drone_frame_removed')) {
      context.handle(
        _droneFrameRemovedMeta,
        droneFrameRemoved.isAcceptableOrUnknown(
          data['drone_frame_removed']!,
          _droneFrameRemovedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_droneFrameRemovedMeta);
    }
    if (data.containsKey('drone_frame_renewed')) {
      context.handle(
        _droneFrameRenewedMeta,
        droneFrameRenewed.isAcceptableOrUnknown(
          data['drone_frame_renewed']!,
          _droneFrameRenewedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_droneFrameRenewedMeta);
    }
    if (data.containsKey('colony_strength')) {
      context.handle(
        _colonyStrengthMeta,
        colonyStrength.isAcceptableOrUnknown(
          data['colony_strength']!,
          _colonyStrengthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_colonyStrengthMeta);
    }
    if (data.containsKey('brood_frames')) {
      context.handle(
        _broodFramesMeta,
        broodFrames.isAcceptableOrUnknown(
          data['brood_frames']!,
          _broodFramesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_broodFramesMeta);
    }
    if (data.containsKey('food_status')) {
      context.handle(
        _foodStatusMeta,
        foodStatus.isAcceptableOrUnknown(data['food_status']!, _foodStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_foodStatusMeta);
    }
    if (data.containsKey('queen_color')) {
      context.handle(
        _queenColorMeta,
        queenColor.isAcceptableOrUnknown(data['queen_color']!, _queenColorMeta),
      );
    } else if (isInserting) {
      context.missing(_queenColorMeta);
    }
    if (data.containsKey('queen_excluder_inserted')) {
      context.handle(
        _queenExcluderInsertedMeta,
        queenExcluderInserted.isAcceptableOrUnknown(
          data['queen_excluder_inserted']!,
          _queenExcluderInsertedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_queenExcluderInsertedMeta);
    }
    if (data.containsKey('honey_supers_count')) {
      context.handle(
        _honeySupersCountMeta,
        honeySupersCount.isAcceptableOrUnknown(
          data['honey_supers_count']!,
          _honeySupersCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_honeySupersCountMeta);
    }
    if (data.containsKey('honey_super_fill_level')) {
      context.handle(
        _honeySuperFillLevelMeta,
        honeySuperFillLevel.isAcceptableOrUnknown(
          data['honey_super_fill_level']!,
          _honeySuperFillLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_honeySuperFillLevelMeta);
    }
    if (data.containsKey('honey_capping_status')) {
      context.handle(
        _honeyCappingStatusMeta,
        honeyCappingStatus.isAcceptableOrUnknown(
          data['honey_capping_status']!,
          _honeyCappingStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_honeyCappingStatusMeta);
    }
    if (data.containsKey('honey_water_content')) {
      context.handle(
        _honeyWaterContentMeta,
        honeyWaterContent.isAcceptableOrUnknown(
          data['honey_water_content']!,
          _honeyWaterContentMeta,
        ),
      );
    }
    if (data.containsKey('bee_escape_inserted')) {
      context.handle(
        _beeEscapeInsertedMeta,
        beeEscapeInserted.isAcceptableOrUnknown(
          data['bee_escape_inserted']!,
          _beeEscapeInsertedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_beeEscapeInsertedMeta);
    }
    if (data.containsKey('varroa_treatment_done')) {
      context.handle(
        _varroaTreatmentDoneMeta,
        varroaTreatmentDone.isAcceptableOrUnknown(
          data['varroa_treatment_done']!,
          _varroaTreatmentDoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_varroaTreatmentDoneMeta);
    }
    if (data.containsKey('varroa_treatment_type')) {
      context.handle(
        _varroaTreatmentTypeMeta,
        varroaTreatmentType.isAcceptableOrUnknown(
          data['varroa_treatment_type']!,
          _varroaTreatmentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_varroaTreatmentTypeMeta);
    }
    if (data.containsKey('feeding_done')) {
      context.handle(
        _feedingDoneMeta,
        feedingDone.isAcceptableOrUnknown(
          data['feeding_done']!,
          _feedingDoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_feedingDoneMeta);
    }
    if (data.containsKey('feeding_type')) {
      context.handle(
        _feedingTypeMeta,
        feedingType.isAcceptableOrUnknown(
          data['feeding_type']!,
          _feedingTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_feedingTypeMeta);
    }
    if (data.containsKey('feeding_amount')) {
      context.handle(
        _feedingAmountMeta,
        feedingAmount.isAcceptableOrUnknown(
          data['feeding_amount']!,
          _feedingAmountMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Inspection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Inspection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      hiveId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hive_id'],
      )!,
      inspectionDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}inspection_date_time'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      )!,
      queenSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}queen_seen'],
      )!,
      combPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comb_position'],
      )!,
      queenCellsSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}queen_cells_seen'],
      )!,
      swarmCellsSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}swarm_cells_seen'],
      )!,
      emergencyCellsSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}emergency_cells_seen'],
      )!,
      cellsRemoved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cells_removed'],
      )!,
      droneFrameFillLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drone_frame_fill_level'],
      )!,
      droneFrameRemoved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}drone_frame_removed'],
      )!,
      droneFrameRenewed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}drone_frame_renewed'],
      )!,
      colonyStrength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}colony_strength'],
      )!,
      broodFrames: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brood_frames'],
      )!,
      foodStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_status'],
      )!,
      queenColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}queen_color'],
      )!,
      queenExcluderInserted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}queen_excluder_inserted'],
      )!,
      honeySupersCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}honey_supers_count'],
      )!,
      honeySuperFillLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}honey_super_fill_level'],
      )!,
      honeyCappingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}honey_capping_status'],
      )!,
      honeyWaterContent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}honey_water_content'],
      ),
      beeEscapeInserted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bee_escape_inserted'],
      )!,
      varroaTreatmentDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}varroa_treatment_done'],
      )!,
      varroaTreatmentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}varroa_treatment_type'],
      )!,
      feedingDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}feeding_done'],
      )!,
      feedingType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feeding_type'],
      )!,
      feedingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}feeding_amount'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InspectionsTable createAlias(String alias) {
    return $InspectionsTable(attachedDatabase, alias);
  }
}

class Inspection extends DataClass implements Insertable<Inspection> {
  final String id;
  final String hiveId;
  final DateTime inspectionDateTime;
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
  final int broodFrames;
  final String foodStatus;
  final String queenColor;
  final bool queenExcluderInserted;
  final int honeySupersCount;
  final String honeySuperFillLevel;
  final String honeyCappingStatus;
  final double? honeyWaterContent;
  final bool beeEscapeInserted;
  final bool varroaTreatmentDone;
  final String varroaTreatmentType;
  final bool feedingDone;
  final String feedingType;
  final double? feedingAmount;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Inspection({
    required this.id,
    required this.hiveId,
    required this.inspectionDateTime,
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
    required this.broodFrames,
    required this.foodStatus,
    required this.queenColor,
    required this.queenExcluderInserted,
    required this.honeySupersCount,
    required this.honeySuperFillLevel,
    required this.honeyCappingStatus,
    this.honeyWaterContent,
    required this.beeEscapeInserted,
    required this.varroaTreatmentDone,
    required this.varroaTreatmentType,
    required this.feedingDone,
    required this.feedingType,
    this.feedingAmount,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['hive_id'] = Variable<String>(hiveId);
    map['inspection_date_time'] = Variable<DateTime>(inspectionDateTime);
    map['mood'] = Variable<String>(mood);
    map['queen_seen'] = Variable<bool>(queenSeen);
    map['comb_position'] = Variable<String>(combPosition);
    map['queen_cells_seen'] = Variable<bool>(queenCellsSeen);
    map['swarm_cells_seen'] = Variable<bool>(swarmCellsSeen);
    map['emergency_cells_seen'] = Variable<bool>(emergencyCellsSeen);
    map['cells_removed'] = Variable<bool>(cellsRemoved);
    map['drone_frame_fill_level'] = Variable<String>(droneFrameFillLevel);
    map['drone_frame_removed'] = Variable<bool>(droneFrameRemoved);
    map['drone_frame_renewed'] = Variable<bool>(droneFrameRenewed);
    map['colony_strength'] = Variable<int>(colonyStrength);
    map['brood_frames'] = Variable<int>(broodFrames);
    map['food_status'] = Variable<String>(foodStatus);
    map['queen_color'] = Variable<String>(queenColor);
    map['queen_excluder_inserted'] = Variable<bool>(queenExcluderInserted);
    map['honey_supers_count'] = Variable<int>(honeySupersCount);
    map['honey_super_fill_level'] = Variable<String>(honeySuperFillLevel);
    map['honey_capping_status'] = Variable<String>(honeyCappingStatus);
    if (!nullToAbsent || honeyWaterContent != null) {
      map['honey_water_content'] = Variable<double>(honeyWaterContent);
    }
    map['bee_escape_inserted'] = Variable<bool>(beeEscapeInserted);
    map['varroa_treatment_done'] = Variable<bool>(varroaTreatmentDone);
    map['varroa_treatment_type'] = Variable<String>(varroaTreatmentType);
    map['feeding_done'] = Variable<bool>(feedingDone);
    map['feeding_type'] = Variable<String>(feedingType);
    if (!nullToAbsent || feedingAmount != null) {
      map['feeding_amount'] = Variable<double>(feedingAmount);
    }
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InspectionsCompanion toCompanion(bool nullToAbsent) {
    return InspectionsCompanion(
      id: Value(id),
      hiveId: Value(hiveId),
      inspectionDateTime: Value(inspectionDateTime),
      mood: Value(mood),
      queenSeen: Value(queenSeen),
      combPosition: Value(combPosition),
      queenCellsSeen: Value(queenCellsSeen),
      swarmCellsSeen: Value(swarmCellsSeen),
      emergencyCellsSeen: Value(emergencyCellsSeen),
      cellsRemoved: Value(cellsRemoved),
      droneFrameFillLevel: Value(droneFrameFillLevel),
      droneFrameRemoved: Value(droneFrameRemoved),
      droneFrameRenewed: Value(droneFrameRenewed),
      colonyStrength: Value(colonyStrength),
      broodFrames: Value(broodFrames),
      foodStatus: Value(foodStatus),
      queenColor: Value(queenColor),
      queenExcluderInserted: Value(queenExcluderInserted),
      honeySupersCount: Value(honeySupersCount),
      honeySuperFillLevel: Value(honeySuperFillLevel),
      honeyCappingStatus: Value(honeyCappingStatus),
      honeyWaterContent: honeyWaterContent == null && nullToAbsent
          ? const Value.absent()
          : Value(honeyWaterContent),
      beeEscapeInserted: Value(beeEscapeInserted),
      varroaTreatmentDone: Value(varroaTreatmentDone),
      varroaTreatmentType: Value(varroaTreatmentType),
      feedingDone: Value(feedingDone),
      feedingType: Value(feedingType),
      feedingAmount: feedingAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(feedingAmount),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Inspection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Inspection(
      id: serializer.fromJson<String>(json['id']),
      hiveId: serializer.fromJson<String>(json['hiveId']),
      inspectionDateTime: serializer.fromJson<DateTime>(
        json['inspectionDateTime'],
      ),
      mood: serializer.fromJson<String>(json['mood']),
      queenSeen: serializer.fromJson<bool>(json['queenSeen']),
      combPosition: serializer.fromJson<String>(json['combPosition']),
      queenCellsSeen: serializer.fromJson<bool>(json['queenCellsSeen']),
      swarmCellsSeen: serializer.fromJson<bool>(json['swarmCellsSeen']),
      emergencyCellsSeen: serializer.fromJson<bool>(json['emergencyCellsSeen']),
      cellsRemoved: serializer.fromJson<bool>(json['cellsRemoved']),
      droneFrameFillLevel: serializer.fromJson<String>(
        json['droneFrameFillLevel'],
      ),
      droneFrameRemoved: serializer.fromJson<bool>(json['droneFrameRemoved']),
      droneFrameRenewed: serializer.fromJson<bool>(json['droneFrameRenewed']),
      colonyStrength: serializer.fromJson<int>(json['colonyStrength']),
      broodFrames: serializer.fromJson<int>(json['broodFrames']),
      foodStatus: serializer.fromJson<String>(json['foodStatus']),
      queenColor: serializer.fromJson<String>(json['queenColor']),
      queenExcluderInserted: serializer.fromJson<bool>(
        json['queenExcluderInserted'],
      ),
      honeySupersCount: serializer.fromJson<int>(json['honeySupersCount']),
      honeySuperFillLevel: serializer.fromJson<String>(
        json['honeySuperFillLevel'],
      ),
      honeyCappingStatus: serializer.fromJson<String>(
        json['honeyCappingStatus'],
      ),
      honeyWaterContent: serializer.fromJson<double?>(
        json['honeyWaterContent'],
      ),
      beeEscapeInserted: serializer.fromJson<bool>(json['beeEscapeInserted']),
      varroaTreatmentDone: serializer.fromJson<bool>(
        json['varroaTreatmentDone'],
      ),
      varroaTreatmentType: serializer.fromJson<String>(
        json['varroaTreatmentType'],
      ),
      feedingDone: serializer.fromJson<bool>(json['feedingDone']),
      feedingType: serializer.fromJson<String>(json['feedingType']),
      feedingAmount: serializer.fromJson<double?>(json['feedingAmount']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hiveId': serializer.toJson<String>(hiveId),
      'inspectionDateTime': serializer.toJson<DateTime>(inspectionDateTime),
      'mood': serializer.toJson<String>(mood),
      'queenSeen': serializer.toJson<bool>(queenSeen),
      'combPosition': serializer.toJson<String>(combPosition),
      'queenCellsSeen': serializer.toJson<bool>(queenCellsSeen),
      'swarmCellsSeen': serializer.toJson<bool>(swarmCellsSeen),
      'emergencyCellsSeen': serializer.toJson<bool>(emergencyCellsSeen),
      'cellsRemoved': serializer.toJson<bool>(cellsRemoved),
      'droneFrameFillLevel': serializer.toJson<String>(droneFrameFillLevel),
      'droneFrameRemoved': serializer.toJson<bool>(droneFrameRemoved),
      'droneFrameRenewed': serializer.toJson<bool>(droneFrameRenewed),
      'colonyStrength': serializer.toJson<int>(colonyStrength),
      'broodFrames': serializer.toJson<int>(broodFrames),
      'foodStatus': serializer.toJson<String>(foodStatus),
      'queenColor': serializer.toJson<String>(queenColor),
      'queenExcluderInserted': serializer.toJson<bool>(queenExcluderInserted),
      'honeySupersCount': serializer.toJson<int>(honeySupersCount),
      'honeySuperFillLevel': serializer.toJson<String>(honeySuperFillLevel),
      'honeyCappingStatus': serializer.toJson<String>(honeyCappingStatus),
      'honeyWaterContent': serializer.toJson<double?>(honeyWaterContent),
      'beeEscapeInserted': serializer.toJson<bool>(beeEscapeInserted),
      'varroaTreatmentDone': serializer.toJson<bool>(varroaTreatmentDone),
      'varroaTreatmentType': serializer.toJson<String>(varroaTreatmentType),
      'feedingDone': serializer.toJson<bool>(feedingDone),
      'feedingType': serializer.toJson<String>(feedingType),
      'feedingAmount': serializer.toJson<double?>(feedingAmount),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Inspection copyWith({
    String? id,
    String? hiveId,
    DateTime? inspectionDateTime,
    String? mood,
    bool? queenSeen,
    String? combPosition,
    bool? queenCellsSeen,
    bool? swarmCellsSeen,
    bool? emergencyCellsSeen,
    bool? cellsRemoved,
    String? droneFrameFillLevel,
    bool? droneFrameRemoved,
    bool? droneFrameRenewed,
    int? colonyStrength,
    int? broodFrames,
    String? foodStatus,
    String? queenColor,
    bool? queenExcluderInserted,
    int? honeySupersCount,
    String? honeySuperFillLevel,
    String? honeyCappingStatus,
    Value<double?> honeyWaterContent = const Value.absent(),
    bool? beeEscapeInserted,
    bool? varroaTreatmentDone,
    String? varroaTreatmentType,
    bool? feedingDone,
    String? feedingType,
    Value<double?> feedingAmount = const Value.absent(),
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Inspection(
    id: id ?? this.id,
    hiveId: hiveId ?? this.hiveId,
    inspectionDateTime: inspectionDateTime ?? this.inspectionDateTime,
    mood: mood ?? this.mood,
    queenSeen: queenSeen ?? this.queenSeen,
    combPosition: combPosition ?? this.combPosition,
    queenCellsSeen: queenCellsSeen ?? this.queenCellsSeen,
    swarmCellsSeen: swarmCellsSeen ?? this.swarmCellsSeen,
    emergencyCellsSeen: emergencyCellsSeen ?? this.emergencyCellsSeen,
    cellsRemoved: cellsRemoved ?? this.cellsRemoved,
    droneFrameFillLevel: droneFrameFillLevel ?? this.droneFrameFillLevel,
    droneFrameRemoved: droneFrameRemoved ?? this.droneFrameRemoved,
    droneFrameRenewed: droneFrameRenewed ?? this.droneFrameRenewed,
    colonyStrength: colonyStrength ?? this.colonyStrength,
    broodFrames: broodFrames ?? this.broodFrames,
    foodStatus: foodStatus ?? this.foodStatus,
    queenColor: queenColor ?? this.queenColor,
    queenExcluderInserted: queenExcluderInserted ?? this.queenExcluderInserted,
    honeySupersCount: honeySupersCount ?? this.honeySupersCount,
    honeySuperFillLevel: honeySuperFillLevel ?? this.honeySuperFillLevel,
    honeyCappingStatus: honeyCappingStatus ?? this.honeyCappingStatus,
    honeyWaterContent: honeyWaterContent.present
        ? honeyWaterContent.value
        : this.honeyWaterContent,
    beeEscapeInserted: beeEscapeInserted ?? this.beeEscapeInserted,
    varroaTreatmentDone: varroaTreatmentDone ?? this.varroaTreatmentDone,
    varroaTreatmentType: varroaTreatmentType ?? this.varroaTreatmentType,
    feedingDone: feedingDone ?? this.feedingDone,
    feedingType: feedingType ?? this.feedingType,
    feedingAmount: feedingAmount.present
        ? feedingAmount.value
        : this.feedingAmount,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Inspection copyWithCompanion(InspectionsCompanion data) {
    return Inspection(
      id: data.id.present ? data.id.value : this.id,
      hiveId: data.hiveId.present ? data.hiveId.value : this.hiveId,
      inspectionDateTime: data.inspectionDateTime.present
          ? data.inspectionDateTime.value
          : this.inspectionDateTime,
      mood: data.mood.present ? data.mood.value : this.mood,
      queenSeen: data.queenSeen.present ? data.queenSeen.value : this.queenSeen,
      combPosition: data.combPosition.present
          ? data.combPosition.value
          : this.combPosition,
      queenCellsSeen: data.queenCellsSeen.present
          ? data.queenCellsSeen.value
          : this.queenCellsSeen,
      swarmCellsSeen: data.swarmCellsSeen.present
          ? data.swarmCellsSeen.value
          : this.swarmCellsSeen,
      emergencyCellsSeen: data.emergencyCellsSeen.present
          ? data.emergencyCellsSeen.value
          : this.emergencyCellsSeen,
      cellsRemoved: data.cellsRemoved.present
          ? data.cellsRemoved.value
          : this.cellsRemoved,
      droneFrameFillLevel: data.droneFrameFillLevel.present
          ? data.droneFrameFillLevel.value
          : this.droneFrameFillLevel,
      droneFrameRemoved: data.droneFrameRemoved.present
          ? data.droneFrameRemoved.value
          : this.droneFrameRemoved,
      droneFrameRenewed: data.droneFrameRenewed.present
          ? data.droneFrameRenewed.value
          : this.droneFrameRenewed,
      colonyStrength: data.colonyStrength.present
          ? data.colonyStrength.value
          : this.colonyStrength,
      broodFrames: data.broodFrames.present
          ? data.broodFrames.value
          : this.broodFrames,
      foodStatus: data.foodStatus.present
          ? data.foodStatus.value
          : this.foodStatus,
      queenColor: data.queenColor.present
          ? data.queenColor.value
          : this.queenColor,
      queenExcluderInserted: data.queenExcluderInserted.present
          ? data.queenExcluderInserted.value
          : this.queenExcluderInserted,
      honeySupersCount: data.honeySupersCount.present
          ? data.honeySupersCount.value
          : this.honeySupersCount,
      honeySuperFillLevel: data.honeySuperFillLevel.present
          ? data.honeySuperFillLevel.value
          : this.honeySuperFillLevel,
      honeyCappingStatus: data.honeyCappingStatus.present
          ? data.honeyCappingStatus.value
          : this.honeyCappingStatus,
      honeyWaterContent: data.honeyWaterContent.present
          ? data.honeyWaterContent.value
          : this.honeyWaterContent,
      beeEscapeInserted: data.beeEscapeInserted.present
          ? data.beeEscapeInserted.value
          : this.beeEscapeInserted,
      varroaTreatmentDone: data.varroaTreatmentDone.present
          ? data.varroaTreatmentDone.value
          : this.varroaTreatmentDone,
      varroaTreatmentType: data.varroaTreatmentType.present
          ? data.varroaTreatmentType.value
          : this.varroaTreatmentType,
      feedingDone: data.feedingDone.present
          ? data.feedingDone.value
          : this.feedingDone,
      feedingType: data.feedingType.present
          ? data.feedingType.value
          : this.feedingType,
      feedingAmount: data.feedingAmount.present
          ? data.feedingAmount.value
          : this.feedingAmount,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Inspection(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('inspectionDateTime: $inspectionDateTime, ')
          ..write('mood: $mood, ')
          ..write('queenSeen: $queenSeen, ')
          ..write('combPosition: $combPosition, ')
          ..write('queenCellsSeen: $queenCellsSeen, ')
          ..write('swarmCellsSeen: $swarmCellsSeen, ')
          ..write('emergencyCellsSeen: $emergencyCellsSeen, ')
          ..write('cellsRemoved: $cellsRemoved, ')
          ..write('droneFrameFillLevel: $droneFrameFillLevel, ')
          ..write('droneFrameRemoved: $droneFrameRemoved, ')
          ..write('droneFrameRenewed: $droneFrameRenewed, ')
          ..write('colonyStrength: $colonyStrength, ')
          ..write('broodFrames: $broodFrames, ')
          ..write('foodStatus: $foodStatus, ')
          ..write('queenColor: $queenColor, ')
          ..write('queenExcluderInserted: $queenExcluderInserted, ')
          ..write('honeySupersCount: $honeySupersCount, ')
          ..write('honeySuperFillLevel: $honeySuperFillLevel, ')
          ..write('honeyCappingStatus: $honeyCappingStatus, ')
          ..write('honeyWaterContent: $honeyWaterContent, ')
          ..write('beeEscapeInserted: $beeEscapeInserted, ')
          ..write('varroaTreatmentDone: $varroaTreatmentDone, ')
          ..write('varroaTreatmentType: $varroaTreatmentType, ')
          ..write('feedingDone: $feedingDone, ')
          ..write('feedingType: $feedingType, ')
          ..write('feedingAmount: $feedingAmount, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    hiveId,
    inspectionDateTime,
    mood,
    queenSeen,
    combPosition,
    queenCellsSeen,
    swarmCellsSeen,
    emergencyCellsSeen,
    cellsRemoved,
    droneFrameFillLevel,
    droneFrameRemoved,
    droneFrameRenewed,
    colonyStrength,
    broodFrames,
    foodStatus,
    queenColor,
    queenExcluderInserted,
    honeySupersCount,
    honeySuperFillLevel,
    honeyCappingStatus,
    honeyWaterContent,
    beeEscapeInserted,
    varroaTreatmentDone,
    varroaTreatmentType,
    feedingDone,
    feedingType,
    feedingAmount,
    notes,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Inspection &&
          other.id == this.id &&
          other.hiveId == this.hiveId &&
          other.inspectionDateTime == this.inspectionDateTime &&
          other.mood == this.mood &&
          other.queenSeen == this.queenSeen &&
          other.combPosition == this.combPosition &&
          other.queenCellsSeen == this.queenCellsSeen &&
          other.swarmCellsSeen == this.swarmCellsSeen &&
          other.emergencyCellsSeen == this.emergencyCellsSeen &&
          other.cellsRemoved == this.cellsRemoved &&
          other.droneFrameFillLevel == this.droneFrameFillLevel &&
          other.droneFrameRemoved == this.droneFrameRemoved &&
          other.droneFrameRenewed == this.droneFrameRenewed &&
          other.colonyStrength == this.colonyStrength &&
          other.broodFrames == this.broodFrames &&
          other.foodStatus == this.foodStatus &&
          other.queenColor == this.queenColor &&
          other.queenExcluderInserted == this.queenExcluderInserted &&
          other.honeySupersCount == this.honeySupersCount &&
          other.honeySuperFillLevel == this.honeySuperFillLevel &&
          other.honeyCappingStatus == this.honeyCappingStatus &&
          other.honeyWaterContent == this.honeyWaterContent &&
          other.beeEscapeInserted == this.beeEscapeInserted &&
          other.varroaTreatmentDone == this.varroaTreatmentDone &&
          other.varroaTreatmentType == this.varroaTreatmentType &&
          other.feedingDone == this.feedingDone &&
          other.feedingType == this.feedingType &&
          other.feedingAmount == this.feedingAmount &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InspectionsCompanion extends UpdateCompanion<Inspection> {
  final Value<String> id;
  final Value<String> hiveId;
  final Value<DateTime> inspectionDateTime;
  final Value<String> mood;
  final Value<bool> queenSeen;
  final Value<String> combPosition;
  final Value<bool> queenCellsSeen;
  final Value<bool> swarmCellsSeen;
  final Value<bool> emergencyCellsSeen;
  final Value<bool> cellsRemoved;
  final Value<String> droneFrameFillLevel;
  final Value<bool> droneFrameRemoved;
  final Value<bool> droneFrameRenewed;
  final Value<int> colonyStrength;
  final Value<int> broodFrames;
  final Value<String> foodStatus;
  final Value<String> queenColor;
  final Value<bool> queenExcluderInserted;
  final Value<int> honeySupersCount;
  final Value<String> honeySuperFillLevel;
  final Value<String> honeyCappingStatus;
  final Value<double?> honeyWaterContent;
  final Value<bool> beeEscapeInserted;
  final Value<bool> varroaTreatmentDone;
  final Value<String> varroaTreatmentType;
  final Value<bool> feedingDone;
  final Value<String> feedingType;
  final Value<double?> feedingAmount;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const InspectionsCompanion({
    this.id = const Value.absent(),
    this.hiveId = const Value.absent(),
    this.inspectionDateTime = const Value.absent(),
    this.mood = const Value.absent(),
    this.queenSeen = const Value.absent(),
    this.combPosition = const Value.absent(),
    this.queenCellsSeen = const Value.absent(),
    this.swarmCellsSeen = const Value.absent(),
    this.emergencyCellsSeen = const Value.absent(),
    this.cellsRemoved = const Value.absent(),
    this.droneFrameFillLevel = const Value.absent(),
    this.droneFrameRemoved = const Value.absent(),
    this.droneFrameRenewed = const Value.absent(),
    this.colonyStrength = const Value.absent(),
    this.broodFrames = const Value.absent(),
    this.foodStatus = const Value.absent(),
    this.queenColor = const Value.absent(),
    this.queenExcluderInserted = const Value.absent(),
    this.honeySupersCount = const Value.absent(),
    this.honeySuperFillLevel = const Value.absent(),
    this.honeyCappingStatus = const Value.absent(),
    this.honeyWaterContent = const Value.absent(),
    this.beeEscapeInserted = const Value.absent(),
    this.varroaTreatmentDone = const Value.absent(),
    this.varroaTreatmentType = const Value.absent(),
    this.feedingDone = const Value.absent(),
    this.feedingType = const Value.absent(),
    this.feedingAmount = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspectionsCompanion.insert({
    required String id,
    required String hiveId,
    required DateTime inspectionDateTime,
    required String mood,
    required bool queenSeen,
    required String combPosition,
    required bool queenCellsSeen,
    required bool swarmCellsSeen,
    required bool emergencyCellsSeen,
    required bool cellsRemoved,
    required String droneFrameFillLevel,
    required bool droneFrameRemoved,
    required bool droneFrameRenewed,
    required int colonyStrength,
    required int broodFrames,
    required String foodStatus,
    required String queenColor,
    required bool queenExcluderInserted,
    required int honeySupersCount,
    required String honeySuperFillLevel,
    required String honeyCappingStatus,
    this.honeyWaterContent = const Value.absent(),
    required bool beeEscapeInserted,
    required bool varroaTreatmentDone,
    required String varroaTreatmentType,
    required bool feedingDone,
    required String feedingType,
    this.feedingAmount = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       hiveId = Value(hiveId),
       inspectionDateTime = Value(inspectionDateTime),
       mood = Value(mood),
       queenSeen = Value(queenSeen),
       combPosition = Value(combPosition),
       queenCellsSeen = Value(queenCellsSeen),
       swarmCellsSeen = Value(swarmCellsSeen),
       emergencyCellsSeen = Value(emergencyCellsSeen),
       cellsRemoved = Value(cellsRemoved),
       droneFrameFillLevel = Value(droneFrameFillLevel),
       droneFrameRemoved = Value(droneFrameRemoved),
       droneFrameRenewed = Value(droneFrameRenewed),
       colonyStrength = Value(colonyStrength),
       broodFrames = Value(broodFrames),
       foodStatus = Value(foodStatus),
       queenColor = Value(queenColor),
       queenExcluderInserted = Value(queenExcluderInserted),
       honeySupersCount = Value(honeySupersCount),
       honeySuperFillLevel = Value(honeySuperFillLevel),
       honeyCappingStatus = Value(honeyCappingStatus),
       beeEscapeInserted = Value(beeEscapeInserted),
       varroaTreatmentDone = Value(varroaTreatmentDone),
       varroaTreatmentType = Value(varroaTreatmentType),
       feedingDone = Value(feedingDone),
       feedingType = Value(feedingType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Inspection> custom({
    Expression<String>? id,
    Expression<String>? hiveId,
    Expression<DateTime>? inspectionDateTime,
    Expression<String>? mood,
    Expression<bool>? queenSeen,
    Expression<String>? combPosition,
    Expression<bool>? queenCellsSeen,
    Expression<bool>? swarmCellsSeen,
    Expression<bool>? emergencyCellsSeen,
    Expression<bool>? cellsRemoved,
    Expression<String>? droneFrameFillLevel,
    Expression<bool>? droneFrameRemoved,
    Expression<bool>? droneFrameRenewed,
    Expression<int>? colonyStrength,
    Expression<int>? broodFrames,
    Expression<String>? foodStatus,
    Expression<String>? queenColor,
    Expression<bool>? queenExcluderInserted,
    Expression<int>? honeySupersCount,
    Expression<String>? honeySuperFillLevel,
    Expression<String>? honeyCappingStatus,
    Expression<double>? honeyWaterContent,
    Expression<bool>? beeEscapeInserted,
    Expression<bool>? varroaTreatmentDone,
    Expression<String>? varroaTreatmentType,
    Expression<bool>? feedingDone,
    Expression<String>? feedingType,
    Expression<double>? feedingAmount,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hiveId != null) 'hive_id': hiveId,
      if (inspectionDateTime != null)
        'inspection_date_time': inspectionDateTime,
      if (mood != null) 'mood': mood,
      if (queenSeen != null) 'queen_seen': queenSeen,
      if (combPosition != null) 'comb_position': combPosition,
      if (queenCellsSeen != null) 'queen_cells_seen': queenCellsSeen,
      if (swarmCellsSeen != null) 'swarm_cells_seen': swarmCellsSeen,
      if (emergencyCellsSeen != null)
        'emergency_cells_seen': emergencyCellsSeen,
      if (cellsRemoved != null) 'cells_removed': cellsRemoved,
      if (droneFrameFillLevel != null)
        'drone_frame_fill_level': droneFrameFillLevel,
      if (droneFrameRemoved != null) 'drone_frame_removed': droneFrameRemoved,
      if (droneFrameRenewed != null) 'drone_frame_renewed': droneFrameRenewed,
      if (colonyStrength != null) 'colony_strength': colonyStrength,
      if (broodFrames != null) 'brood_frames': broodFrames,
      if (foodStatus != null) 'food_status': foodStatus,
      if (queenColor != null) 'queen_color': queenColor,
      if (queenExcluderInserted != null)
        'queen_excluder_inserted': queenExcluderInserted,
      if (honeySupersCount != null) 'honey_supers_count': honeySupersCount,
      if (honeySuperFillLevel != null)
        'honey_super_fill_level': honeySuperFillLevel,
      if (honeyCappingStatus != null)
        'honey_capping_status': honeyCappingStatus,
      if (honeyWaterContent != null) 'honey_water_content': honeyWaterContent,
      if (beeEscapeInserted != null) 'bee_escape_inserted': beeEscapeInserted,
      if (varroaTreatmentDone != null)
        'varroa_treatment_done': varroaTreatmentDone,
      if (varroaTreatmentType != null)
        'varroa_treatment_type': varroaTreatmentType,
      if (feedingDone != null) 'feeding_done': feedingDone,
      if (feedingType != null) 'feeding_type': feedingType,
      if (feedingAmount != null) 'feeding_amount': feedingAmount,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? hiveId,
    Value<DateTime>? inspectionDateTime,
    Value<String>? mood,
    Value<bool>? queenSeen,
    Value<String>? combPosition,
    Value<bool>? queenCellsSeen,
    Value<bool>? swarmCellsSeen,
    Value<bool>? emergencyCellsSeen,
    Value<bool>? cellsRemoved,
    Value<String>? droneFrameFillLevel,
    Value<bool>? droneFrameRemoved,
    Value<bool>? droneFrameRenewed,
    Value<int>? colonyStrength,
    Value<int>? broodFrames,
    Value<String>? foodStatus,
    Value<String>? queenColor,
    Value<bool>? queenExcluderInserted,
    Value<int>? honeySupersCount,
    Value<String>? honeySuperFillLevel,
    Value<String>? honeyCappingStatus,
    Value<double?>? honeyWaterContent,
    Value<bool>? beeEscapeInserted,
    Value<bool>? varroaTreatmentDone,
    Value<String>? varroaTreatmentType,
    Value<bool>? feedingDone,
    Value<String>? feedingType,
    Value<double?>? feedingAmount,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return InspectionsCompanion(
      id: id ?? this.id,
      hiveId: hiveId ?? this.hiveId,
      inspectionDateTime: inspectionDateTime ?? this.inspectionDateTime,
      mood: mood ?? this.mood,
      queenSeen: queenSeen ?? this.queenSeen,
      combPosition: combPosition ?? this.combPosition,
      queenCellsSeen: queenCellsSeen ?? this.queenCellsSeen,
      swarmCellsSeen: swarmCellsSeen ?? this.swarmCellsSeen,
      emergencyCellsSeen: emergencyCellsSeen ?? this.emergencyCellsSeen,
      cellsRemoved: cellsRemoved ?? this.cellsRemoved,
      droneFrameFillLevel: droneFrameFillLevel ?? this.droneFrameFillLevel,
      droneFrameRemoved: droneFrameRemoved ?? this.droneFrameRemoved,
      droneFrameRenewed: droneFrameRenewed ?? this.droneFrameRenewed,
      colonyStrength: colonyStrength ?? this.colonyStrength,
      broodFrames: broodFrames ?? this.broodFrames,
      foodStatus: foodStatus ?? this.foodStatus,
      queenColor: queenColor ?? this.queenColor,
      queenExcluderInserted:
          queenExcluderInserted ?? this.queenExcluderInserted,
      honeySupersCount: honeySupersCount ?? this.honeySupersCount,
      honeySuperFillLevel: honeySuperFillLevel ?? this.honeySuperFillLevel,
      honeyCappingStatus: honeyCappingStatus ?? this.honeyCappingStatus,
      honeyWaterContent: honeyWaterContent ?? this.honeyWaterContent,
      beeEscapeInserted: beeEscapeInserted ?? this.beeEscapeInserted,
      varroaTreatmentDone: varroaTreatmentDone ?? this.varroaTreatmentDone,
      varroaTreatmentType: varroaTreatmentType ?? this.varroaTreatmentType,
      feedingDone: feedingDone ?? this.feedingDone,
      feedingType: feedingType ?? this.feedingType,
      feedingAmount: feedingAmount ?? this.feedingAmount,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hiveId.present) {
      map['hive_id'] = Variable<String>(hiveId.value);
    }
    if (inspectionDateTime.present) {
      map['inspection_date_time'] = Variable<DateTime>(
        inspectionDateTime.value,
      );
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (queenSeen.present) {
      map['queen_seen'] = Variable<bool>(queenSeen.value);
    }
    if (combPosition.present) {
      map['comb_position'] = Variable<String>(combPosition.value);
    }
    if (queenCellsSeen.present) {
      map['queen_cells_seen'] = Variable<bool>(queenCellsSeen.value);
    }
    if (swarmCellsSeen.present) {
      map['swarm_cells_seen'] = Variable<bool>(swarmCellsSeen.value);
    }
    if (emergencyCellsSeen.present) {
      map['emergency_cells_seen'] = Variable<bool>(emergencyCellsSeen.value);
    }
    if (cellsRemoved.present) {
      map['cells_removed'] = Variable<bool>(cellsRemoved.value);
    }
    if (droneFrameFillLevel.present) {
      map['drone_frame_fill_level'] = Variable<String>(
        droneFrameFillLevel.value,
      );
    }
    if (droneFrameRemoved.present) {
      map['drone_frame_removed'] = Variable<bool>(droneFrameRemoved.value);
    }
    if (droneFrameRenewed.present) {
      map['drone_frame_renewed'] = Variable<bool>(droneFrameRenewed.value);
    }
    if (colonyStrength.present) {
      map['colony_strength'] = Variable<int>(colonyStrength.value);
    }
    if (broodFrames.present) {
      map['brood_frames'] = Variable<int>(broodFrames.value);
    }
    if (foodStatus.present) {
      map['food_status'] = Variable<String>(foodStatus.value);
    }
    if (queenColor.present) {
      map['queen_color'] = Variable<String>(queenColor.value);
    }
    if (queenExcluderInserted.present) {
      map['queen_excluder_inserted'] = Variable<bool>(
        queenExcluderInserted.value,
      );
    }
    if (honeySupersCount.present) {
      map['honey_supers_count'] = Variable<int>(honeySupersCount.value);
    }
    if (honeySuperFillLevel.present) {
      map['honey_super_fill_level'] = Variable<String>(
        honeySuperFillLevel.value,
      );
    }
    if (honeyCappingStatus.present) {
      map['honey_capping_status'] = Variable<String>(honeyCappingStatus.value);
    }
    if (honeyWaterContent.present) {
      map['honey_water_content'] = Variable<double>(honeyWaterContent.value);
    }
    if (beeEscapeInserted.present) {
      map['bee_escape_inserted'] = Variable<bool>(beeEscapeInserted.value);
    }
    if (varroaTreatmentDone.present) {
      map['varroa_treatment_done'] = Variable<bool>(varroaTreatmentDone.value);
    }
    if (varroaTreatmentType.present) {
      map['varroa_treatment_type'] = Variable<String>(
        varroaTreatmentType.value,
      );
    }
    if (feedingDone.present) {
      map['feeding_done'] = Variable<bool>(feedingDone.value);
    }
    if (feedingType.present) {
      map['feeding_type'] = Variable<String>(feedingType.value);
    }
    if (feedingAmount.present) {
      map['feeding_amount'] = Variable<double>(feedingAmount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionsCompanion(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('inspectionDateTime: $inspectionDateTime, ')
          ..write('mood: $mood, ')
          ..write('queenSeen: $queenSeen, ')
          ..write('combPosition: $combPosition, ')
          ..write('queenCellsSeen: $queenCellsSeen, ')
          ..write('swarmCellsSeen: $swarmCellsSeen, ')
          ..write('emergencyCellsSeen: $emergencyCellsSeen, ')
          ..write('cellsRemoved: $cellsRemoved, ')
          ..write('droneFrameFillLevel: $droneFrameFillLevel, ')
          ..write('droneFrameRemoved: $droneFrameRemoved, ')
          ..write('droneFrameRenewed: $droneFrameRenewed, ')
          ..write('colonyStrength: $colonyStrength, ')
          ..write('broodFrames: $broodFrames, ')
          ..write('foodStatus: $foodStatus, ')
          ..write('queenColor: $queenColor, ')
          ..write('queenExcluderInserted: $queenExcluderInserted, ')
          ..write('honeySupersCount: $honeySupersCount, ')
          ..write('honeySuperFillLevel: $honeySuperFillLevel, ')
          ..write('honeyCappingStatus: $honeyCappingStatus, ')
          ..write('honeyWaterContent: $honeyWaterContent, ')
          ..write('beeEscapeInserted: $beeEscapeInserted, ')
          ..write('varroaTreatmentDone: $varroaTreatmentDone, ')
          ..write('varroaTreatmentType: $varroaTreatmentType, ')
          ..write('feedingDone: $feedingDone, ')
          ..write('feedingType: $feedingType, ')
          ..write('feedingAmount: $feedingAmount, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hiveIdMeta = const VerificationMeta('hiveId');
  @override
  late final GeneratedColumn<String> hiveId = GeneratedColumn<String>(
    'hive_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES hives(id)',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateTimeMeta = const VerificationMeta(
    'dueDateTime',
  );
  @override
  late final GeneratedColumn<DateTime> dueDateTime = GeneratedColumn<DateTime>(
    'due_date_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hiveId,
    title,
    description,
    category,
    dueDateTime,
    priority,
    status,
    createdAt,
    completedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hive_id')) {
      context.handle(
        _hiveIdMeta,
        hiveId.isAcceptableOrUnknown(data['hive_id']!, _hiveIdMeta),
      );
    } else if (isInserting) {
      context.missing(_hiveIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('due_date_time')) {
      context.handle(
        _dueDateTimeMeta,
        dueDateTime.isAcceptableOrUnknown(
          data['due_date_time']!,
          _dueDateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dueDateTimeMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      hiveId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hive_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      dueDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date_time'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String hiveId;
  final String title;
  final String description;
  final String category;
  final DateTime dueDateTime;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime updatedAt;
  const Task({
    required this.id,
    required this.hiveId,
    required this.title,
    required this.description,
    required this.category,
    required this.dueDateTime,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['hive_id'] = Variable<String>(hiveId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['due_date_time'] = Variable<DateTime>(dueDateTime);
    map['priority'] = Variable<String>(priority);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      hiveId: Value(hiveId),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      dueDateTime: Value(dueDateTime),
      priority: Value(priority),
      status: Value(status),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      hiveId: serializer.fromJson<String>(json['hiveId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      dueDateTime: serializer.fromJson<DateTime>(json['dueDateTime']),
      priority: serializer.fromJson<String>(json['priority']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hiveId': serializer.toJson<String>(hiveId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'dueDateTime': serializer.toJson<DateTime>(dueDateTime),
      'priority': serializer.toJson<String>(priority),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Task copyWith({
    String? id,
    String? hiveId,
    String? title,
    String? description,
    String? category,
    DateTime? dueDateTime,
    String? priority,
    String? status,
    DateTime? createdAt,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => Task(
    id: id ?? this.id,
    hiveId: hiveId ?? this.hiveId,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    dueDateTime: dueDateTime ?? this.dueDateTime,
    priority: priority ?? this.priority,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      hiveId: data.hiveId.present ? data.hiveId.value : this.hiveId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      dueDateTime: data.dueDateTime.present
          ? data.dueDateTime.value
          : this.dueDateTime,
      priority: data.priority.present ? data.priority.value : this.priority,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('dueDateTime: $dueDateTime, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    hiveId,
    title,
    description,
    category,
    dueDateTime,
    priority,
    status,
    createdAt,
    completedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.hiveId == this.hiveId &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.dueDateTime == this.dueDateTime &&
          other.priority == this.priority &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> hiveId;
  final Value<String> title;
  final Value<String> description;
  final Value<String> category;
  final Value<DateTime> dueDateTime;
  final Value<String> priority;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.hiveId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.dueDateTime = const Value.absent(),
    this.priority = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String hiveId,
    required String title,
    this.description = const Value.absent(),
    required String category,
    required DateTime dueDateTime,
    required String priority,
    required String status,
    required DateTime createdAt,
    this.completedAt = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       hiveId = Value(hiveId),
       title = Value(title),
       category = Value(category),
       dueDateTime = Value(dueDateTime),
       priority = Value(priority),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? hiveId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<DateTime>? dueDateTime,
    Expression<String>? priority,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hiveId != null) 'hive_id': hiveId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (dueDateTime != null) 'due_date_time': dueDateTime,
      if (priority != null) 'priority': priority,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? hiveId,
    Value<String>? title,
    Value<String>? description,
    Value<String>? category,
    Value<DateTime>? dueDateTime,
    Value<String>? priority,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      hiveId: hiveId ?? this.hiveId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      dueDateTime: dueDateTime ?? this.dueDateTime,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hiveId.present) {
      map['hive_id'] = Variable<String>(hiveId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (dueDateTime.present) {
      map['due_date_time'] = Variable<DateTime>(dueDateTime.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('dueDateTime: $dueDateTime, ')
          ..write('priority: $priority, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InspectionPhotosTable extends InspectionPhotos
    with TableInfo<$InspectionPhotosTable, InspectionPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InspectionPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inspectionIdMeta = const VerificationMeta(
    'inspectionId',
  );
  @override
  late final GeneratedColumn<String> inspectionId = GeneratedColumn<String>(
    'inspection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES inspections(id)',
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalFilenameMeta = const VerificationMeta(
    'originalFilename',
  );
  @override
  late final GeneratedColumn<String> originalFilename = GeneratedColumn<String>(
    'original_filename',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    inspectionId,
    localPath,
    originalFilename,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inspection_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<InspectionPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('inspection_id')) {
      context.handle(
        _inspectionIdMeta,
        inspectionId.isAcceptableOrUnknown(
          data['inspection_id']!,
          _inspectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inspectionIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('original_filename')) {
      context.handle(
        _originalFilenameMeta,
        originalFilename.isAcceptableOrUnknown(
          data['original_filename']!,
          _originalFilenameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalFilenameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InspectionPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InspectionPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      inspectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inspection_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      originalFilename: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_filename'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InspectionPhotosTable createAlias(String alias) {
    return $InspectionPhotosTable(attachedDatabase, alias);
  }
}

class InspectionPhoto extends DataClass implements Insertable<InspectionPhoto> {
  final String id;
  final String inspectionId;
  final String localPath;
  final String originalFilename;
  final DateTime createdAt;
  const InspectionPhoto({
    required this.id,
    required this.inspectionId,
    required this.localPath,
    required this.originalFilename,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['inspection_id'] = Variable<String>(inspectionId);
    map['local_path'] = Variable<String>(localPath);
    map['original_filename'] = Variable<String>(originalFilename);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InspectionPhotosCompanion toCompanion(bool nullToAbsent) {
    return InspectionPhotosCompanion(
      id: Value(id),
      inspectionId: Value(inspectionId),
      localPath: Value(localPath),
      originalFilename: Value(originalFilename),
      createdAt: Value(createdAt),
    );
  }

  factory InspectionPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InspectionPhoto(
      id: serializer.fromJson<String>(json['id']),
      inspectionId: serializer.fromJson<String>(json['inspectionId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      originalFilename: serializer.fromJson<String>(json['originalFilename']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'inspectionId': serializer.toJson<String>(inspectionId),
      'localPath': serializer.toJson<String>(localPath),
      'originalFilename': serializer.toJson<String>(originalFilename),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InspectionPhoto copyWith({
    String? id,
    String? inspectionId,
    String? localPath,
    String? originalFilename,
    DateTime? createdAt,
  }) => InspectionPhoto(
    id: id ?? this.id,
    inspectionId: inspectionId ?? this.inspectionId,
    localPath: localPath ?? this.localPath,
    originalFilename: originalFilename ?? this.originalFilename,
    createdAt: createdAt ?? this.createdAt,
  );
  InspectionPhoto copyWithCompanion(InspectionPhotosCompanion data) {
    return InspectionPhoto(
      id: data.id.present ? data.id.value : this.id,
      inspectionId: data.inspectionId.present
          ? data.inspectionId.value
          : this.inspectionId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      originalFilename: data.originalFilename.present
          ? data.originalFilename.value
          : this.originalFilename,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InspectionPhoto(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('localPath: $localPath, ')
          ..write('originalFilename: $originalFilename, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, inspectionId, localPath, originalFilename, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InspectionPhoto &&
          other.id == this.id &&
          other.inspectionId == this.inspectionId &&
          other.localPath == this.localPath &&
          other.originalFilename == this.originalFilename &&
          other.createdAt == this.createdAt);
}

class InspectionPhotosCompanion extends UpdateCompanion<InspectionPhoto> {
  final Value<String> id;
  final Value<String> inspectionId;
  final Value<String> localPath;
  final Value<String> originalFilename;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InspectionPhotosCompanion({
    this.id = const Value.absent(),
    this.inspectionId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.originalFilename = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InspectionPhotosCompanion.insert({
    required String id,
    required String inspectionId,
    required String localPath,
    required String originalFilename,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       inspectionId = Value(inspectionId),
       localPath = Value(localPath),
       originalFilename = Value(originalFilename),
       createdAt = Value(createdAt);
  static Insertable<InspectionPhoto> custom({
    Expression<String>? id,
    Expression<String>? inspectionId,
    Expression<String>? localPath,
    Expression<String>? originalFilename,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inspectionId != null) 'inspection_id': inspectionId,
      if (localPath != null) 'local_path': localPath,
      if (originalFilename != null) 'original_filename': originalFilename,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InspectionPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? inspectionId,
    Value<String>? localPath,
    Value<String>? originalFilename,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InspectionPhotosCompanion(
      id: id ?? this.id,
      inspectionId: inspectionId ?? this.inspectionId,
      localPath: localPath ?? this.localPath,
      originalFilename: originalFilename ?? this.originalFilename,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (inspectionId.present) {
      map['inspection_id'] = Variable<String>(inspectionId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (originalFilename.present) {
      map['original_filename'] = Variable<String>(originalFilename.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InspectionPhotosCompanion(')
          ..write('id: $id, ')
          ..write('inspectionId: $inspectionId, ')
          ..write('localPath: $localPath, ')
          ..write('originalFilename: $originalFilename, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotoAttachmentsTable extends PhotoAttachments
    with TableInfo<$PhotoAttachmentsTable, PhotoAttachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filenameMeta = const VerificationMeta(
    'filename',
  );
  @override
  late final GeneratedColumn<String> filename = GeneratedColumn<String>(
    'filename',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkedHiveIdMeta = const VerificationMeta(
    'linkedHiveId',
  );
  @override
  late final GeneratedColumn<String> linkedHiveId = GeneratedColumn<String>(
    'linked_hive_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedInspectionIdMeta =
      const VerificationMeta('linkedInspectionId');
  @override
  late final GeneratedColumn<String> linkedInspectionId =
      GeneratedColumn<String>(
        'linked_inspection_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localPath,
    filename,
    linkedHiveId,
    linkedInspectionId,
    type,
    createdAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoAttachment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('filename')) {
      context.handle(
        _filenameMeta,
        filename.isAcceptableOrUnknown(data['filename']!, _filenameMeta),
      );
    } else if (isInserting) {
      context.missing(_filenameMeta);
    }
    if (data.containsKey('linked_hive_id')) {
      context.handle(
        _linkedHiveIdMeta,
        linkedHiveId.isAcceptableOrUnknown(
          data['linked_hive_id']!,
          _linkedHiveIdMeta,
        ),
      );
    }
    if (data.containsKey('linked_inspection_id')) {
      context.handle(
        _linkedInspectionIdMeta,
        linkedInspectionId.isAcceptableOrUnknown(
          data['linked_inspection_id']!,
          _linkedInspectionIdMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoAttachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoAttachment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      filename: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}filename'],
      )!,
      linkedHiveId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_hive_id'],
      ),
      linkedInspectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_inspection_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $PhotoAttachmentsTable createAlias(String alias) {
    return $PhotoAttachmentsTable(attachedDatabase, alias);
  }
}

class PhotoAttachment extends DataClass implements Insertable<PhotoAttachment> {
  final String id;
  final String localPath;
  final String filename;
  final String? linkedHiveId;
  final String? linkedInspectionId;
  final String type;
  final DateTime createdAt;
  final String notes;
  const PhotoAttachment({
    required this.id,
    required this.localPath,
    required this.filename,
    this.linkedHiveId,
    this.linkedInspectionId,
    required this.type,
    required this.createdAt,
    required this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_path'] = Variable<String>(localPath);
    map['filename'] = Variable<String>(filename);
    if (!nullToAbsent || linkedHiveId != null) {
      map['linked_hive_id'] = Variable<String>(linkedHiveId);
    }
    if (!nullToAbsent || linkedInspectionId != null) {
      map['linked_inspection_id'] = Variable<String>(linkedInspectionId);
    }
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  PhotoAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return PhotoAttachmentsCompanion(
      id: Value(id),
      localPath: Value(localPath),
      filename: Value(filename),
      linkedHiveId: linkedHiveId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedHiveId),
      linkedInspectionId: linkedInspectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedInspectionId),
      type: Value(type),
      createdAt: Value(createdAt),
      notes: Value(notes),
    );
  }

  factory PhotoAttachment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoAttachment(
      id: serializer.fromJson<String>(json['id']),
      localPath: serializer.fromJson<String>(json['localPath']),
      filename: serializer.fromJson<String>(json['filename']),
      linkedHiveId: serializer.fromJson<String?>(json['linkedHiveId']),
      linkedInspectionId: serializer.fromJson<String?>(
        json['linkedInspectionId'],
      ),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localPath': serializer.toJson<String>(localPath),
      'filename': serializer.toJson<String>(filename),
      'linkedHiveId': serializer.toJson<String?>(linkedHiveId),
      'linkedInspectionId': serializer.toJson<String?>(linkedInspectionId),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'notes': serializer.toJson<String>(notes),
    };
  }

  PhotoAttachment copyWith({
    String? id,
    String? localPath,
    String? filename,
    Value<String?> linkedHiveId = const Value.absent(),
    Value<String?> linkedInspectionId = const Value.absent(),
    String? type,
    DateTime? createdAt,
    String? notes,
  }) => PhotoAttachment(
    id: id ?? this.id,
    localPath: localPath ?? this.localPath,
    filename: filename ?? this.filename,
    linkedHiveId: linkedHiveId.present ? linkedHiveId.value : this.linkedHiveId,
    linkedInspectionId: linkedInspectionId.present
        ? linkedInspectionId.value
        : this.linkedInspectionId,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    notes: notes ?? this.notes,
  );
  PhotoAttachment copyWithCompanion(PhotoAttachmentsCompanion data) {
    return PhotoAttachment(
      id: data.id.present ? data.id.value : this.id,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      filename: data.filename.present ? data.filename.value : this.filename,
      linkedHiveId: data.linkedHiveId.present
          ? data.linkedHiveId.value
          : this.linkedHiveId,
      linkedInspectionId: data.linkedInspectionId.present
          ? data.linkedInspectionId.value
          : this.linkedInspectionId,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoAttachment(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('filename: $filename, ')
          ..write('linkedHiveId: $linkedHiveId, ')
          ..write('linkedInspectionId: $linkedInspectionId, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localPath,
    filename,
    linkedHiveId,
    linkedInspectionId,
    type,
    createdAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoAttachment &&
          other.id == this.id &&
          other.localPath == this.localPath &&
          other.filename == this.filename &&
          other.linkedHiveId == this.linkedHiveId &&
          other.linkedInspectionId == this.linkedInspectionId &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.notes == this.notes);
}

class PhotoAttachmentsCompanion extends UpdateCompanion<PhotoAttachment> {
  final Value<String> id;
  final Value<String> localPath;
  final Value<String> filename;
  final Value<String?> linkedHiveId;
  final Value<String?> linkedInspectionId;
  final Value<String> type;
  final Value<DateTime> createdAt;
  final Value<String> notes;
  final Value<int> rowid;
  const PhotoAttachmentsCompanion({
    this.id = const Value.absent(),
    this.localPath = const Value.absent(),
    this.filename = const Value.absent(),
    this.linkedHiveId = const Value.absent(),
    this.linkedInspectionId = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoAttachmentsCompanion.insert({
    required String id,
    required String localPath,
    required String filename,
    this.linkedHiveId = const Value.absent(),
    this.linkedInspectionId = const Value.absent(),
    required String type,
    required DateTime createdAt,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localPath = Value(localPath),
       filename = Value(filename),
       type = Value(type),
       createdAt = Value(createdAt);
  static Insertable<PhotoAttachment> custom({
    Expression<String>? id,
    Expression<String>? localPath,
    Expression<String>? filename,
    Expression<String>? linkedHiveId,
    Expression<String>? linkedInspectionId,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localPath != null) 'local_path': localPath,
      if (filename != null) 'filename': filename,
      if (linkedHiveId != null) 'linked_hive_id': linkedHiveId,
      if (linkedInspectionId != null)
        'linked_inspection_id': linkedInspectionId,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoAttachmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? localPath,
    Value<String>? filename,
    Value<String?>? linkedHiveId,
    Value<String?>? linkedInspectionId,
    Value<String>? type,
    Value<DateTime>? createdAt,
    Value<String>? notes,
    Value<int>? rowid,
  }) {
    return PhotoAttachmentsCompanion(
      id: id ?? this.id,
      localPath: localPath ?? this.localPath,
      filename: filename ?? this.filename,
      linkedHiveId: linkedHiveId ?? this.linkedHiveId,
      linkedInspectionId: linkedInspectionId ?? this.linkedInspectionId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (filename.present) {
      map['filename'] = Variable<String>(filename.value);
    }
    if (linkedHiveId.present) {
      map['linked_hive_id'] = Variable<String>(linkedHiveId.value);
    }
    if (linkedInspectionId.present) {
      map['linked_inspection_id'] = Variable<String>(linkedInspectionId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoAttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('localPath: $localPath, ')
          ..write('filename: $filename, ')
          ..write('linkedHiveId: $linkedHiveId, ')
          ..write('linkedInspectionId: $linkedInspectionId, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HoneyBookEntriesTable extends HoneyBookEntries
    with TableInfo<$HoneyBookEntriesTable, HoneyBookEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HoneyBookEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _runningNumberMeta = const VerificationMeta(
    'runningNumber',
  );
  @override
  late final GeneratedColumn<String> runningNumber = GeneratedColumn<String>(
    'running_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _harvestDateMeta = const VerificationMeta(
    'harvestDate',
  );
  @override
  late final GeneratedColumn<DateTime> harvestDate = GeneratedColumn<DateTime>(
    'harvest_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extractionLocationMeta =
      const VerificationMeta('extractionLocation');
  @override
  late final GeneratedColumn<String> extractionLocation =
      GeneratedColumn<String>(
        'extraction_location',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _honeyTypeMeta = const VerificationMeta(
    'honeyType',
  );
  @override
  late final GeneratedColumn<String> honeyType = GeneratedColumn<String>(
    'honey_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterContentPercentMeta =
      const VerificationMeta('waterContentPercent');
  @override
  late final GeneratedColumn<double> waterContentPercent =
      GeneratedColumn<double>(
        'water_content_percent',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _amountKgMeta = const VerificationMeta(
    'amountKg',
  );
  @override
  late final GeneratedColumn<double> amountKg = GeneratedColumn<double>(
    'amount_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bottledAtMeta = const VerificationMeta(
    'bottledAt',
  );
  @override
  late final GeneratedColumn<DateTime> bottledAt = GeneratedColumn<DateTime>(
    'bottled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelNumberFromMeta = const VerificationMeta(
    'labelNumberFrom',
  );
  @override
  late final GeneratedColumn<String> labelNumberFrom = GeneratedColumn<String>(
    'label_number_from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _labelNumberToMeta = const VerificationMeta(
    'labelNumberTo',
  );
  @override
  late final GeneratedColumn<String> labelNumberTo = GeneratedColumn<String>(
    'label_number_to',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bestBeforeDateMeta = const VerificationMeta(
    'bestBeforeDate',
  );
  @override
  late final GeneratedColumn<DateTime> bestBeforeDate =
      GeneratedColumn<DateTime>(
        'best_before_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _processingTypeMeta = const VerificationMeta(
    'processingType',
  );
  @override
  late final GeneratedColumn<String> processingType = GeneratedColumn<String>(
    'processing_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _originNoteMeta = const VerificationMeta(
    'originNote',
  );
  @override
  late final GeneratedColumn<String> originNote = GeneratedColumn<String>(
    'origin_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    runningNumber,
    harvestDate,
    extractionLocation,
    honeyType,
    waterContentPercent,
    amountKg,
    bottledAt,
    labelNumberFrom,
    labelNumberTo,
    batchNumber,
    bestBeforeDate,
    processingType,
    notes,
    originNote,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'honey_book_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<HoneyBookEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('running_number')) {
      context.handle(
        _runningNumberMeta,
        runningNumber.isAcceptableOrUnknown(
          data['running_number']!,
          _runningNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_runningNumberMeta);
    }
    if (data.containsKey('harvest_date')) {
      context.handle(
        _harvestDateMeta,
        harvestDate.isAcceptableOrUnknown(
          data['harvest_date']!,
          _harvestDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_harvestDateMeta);
    }
    if (data.containsKey('extraction_location')) {
      context.handle(
        _extractionLocationMeta,
        extractionLocation.isAcceptableOrUnknown(
          data['extraction_location']!,
          _extractionLocationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_extractionLocationMeta);
    }
    if (data.containsKey('honey_type')) {
      context.handle(
        _honeyTypeMeta,
        honeyType.isAcceptableOrUnknown(data['honey_type']!, _honeyTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_honeyTypeMeta);
    }
    if (data.containsKey('water_content_percent')) {
      context.handle(
        _waterContentPercentMeta,
        waterContentPercent.isAcceptableOrUnknown(
          data['water_content_percent']!,
          _waterContentPercentMeta,
        ),
      );
    }
    if (data.containsKey('amount_kg')) {
      context.handle(
        _amountKgMeta,
        amountKg.isAcceptableOrUnknown(data['amount_kg']!, _amountKgMeta),
      );
    } else if (isInserting) {
      context.missing(_amountKgMeta);
    }
    if (data.containsKey('bottled_at')) {
      context.handle(
        _bottledAtMeta,
        bottledAt.isAcceptableOrUnknown(data['bottled_at']!, _bottledAtMeta),
      );
    }
    if (data.containsKey('label_number_from')) {
      context.handle(
        _labelNumberFromMeta,
        labelNumberFrom.isAcceptableOrUnknown(
          data['label_number_from']!,
          _labelNumberFromMeta,
        ),
      );
    }
    if (data.containsKey('label_number_to')) {
      context.handle(
        _labelNumberToMeta,
        labelNumberTo.isAcceptableOrUnknown(
          data['label_number_to']!,
          _labelNumberToMeta,
        ),
      );
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    }
    if (data.containsKey('best_before_date')) {
      context.handle(
        _bestBeforeDateMeta,
        bestBeforeDate.isAcceptableOrUnknown(
          data['best_before_date']!,
          _bestBeforeDateMeta,
        ),
      );
    }
    if (data.containsKey('processing_type')) {
      context.handle(
        _processingTypeMeta,
        processingType.isAcceptableOrUnknown(
          data['processing_type']!,
          _processingTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_processingTypeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('origin_note')) {
      context.handle(
        _originNoteMeta,
        originNote.isAcceptableOrUnknown(data['origin_note']!, _originNoteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HoneyBookEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HoneyBookEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      runningNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}running_number'],
      )!,
      harvestDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}harvest_date'],
      )!,
      extractionLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extraction_location'],
      )!,
      honeyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}honey_type'],
      )!,
      waterContentPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_content_percent'],
      ),
      amountKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_kg'],
      )!,
      bottledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bottled_at'],
      ),
      labelNumberFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_number_from'],
      )!,
      labelNumberTo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_number_to'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      )!,
      bestBeforeDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}best_before_date'],
      ),
      processingType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_type'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      originNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_note'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HoneyBookEntriesTable createAlias(String alias) {
    return $HoneyBookEntriesTable(attachedDatabase, alias);
  }
}

class HoneyBookEntry extends DataClass implements Insertable<HoneyBookEntry> {
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
  final String processingType;
  final String notes;
  final String originNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  const HoneyBookEntry({
    required this.id,
    required this.runningNumber,
    required this.harvestDate,
    required this.extractionLocation,
    required this.honeyType,
    this.waterContentPercent,
    required this.amountKg,
    this.bottledAt,
    required this.labelNumberFrom,
    required this.labelNumberTo,
    required this.batchNumber,
    this.bestBeforeDate,
    required this.processingType,
    required this.notes,
    required this.originNote,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['running_number'] = Variable<String>(runningNumber);
    map['harvest_date'] = Variable<DateTime>(harvestDate);
    map['extraction_location'] = Variable<String>(extractionLocation);
    map['honey_type'] = Variable<String>(honeyType);
    if (!nullToAbsent || waterContentPercent != null) {
      map['water_content_percent'] = Variable<double>(waterContentPercent);
    }
    map['amount_kg'] = Variable<double>(amountKg);
    if (!nullToAbsent || bottledAt != null) {
      map['bottled_at'] = Variable<DateTime>(bottledAt);
    }
    map['label_number_from'] = Variable<String>(labelNumberFrom);
    map['label_number_to'] = Variable<String>(labelNumberTo);
    map['batch_number'] = Variable<String>(batchNumber);
    if (!nullToAbsent || bestBeforeDate != null) {
      map['best_before_date'] = Variable<DateTime>(bestBeforeDate);
    }
    map['processing_type'] = Variable<String>(processingType);
    map['notes'] = Variable<String>(notes);
    map['origin_note'] = Variable<String>(originNote);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HoneyBookEntriesCompanion toCompanion(bool nullToAbsent) {
    return HoneyBookEntriesCompanion(
      id: Value(id),
      runningNumber: Value(runningNumber),
      harvestDate: Value(harvestDate),
      extractionLocation: Value(extractionLocation),
      honeyType: Value(honeyType),
      waterContentPercent: waterContentPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(waterContentPercent),
      amountKg: Value(amountKg),
      bottledAt: bottledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(bottledAt),
      labelNumberFrom: Value(labelNumberFrom),
      labelNumberTo: Value(labelNumberTo),
      batchNumber: Value(batchNumber),
      bestBeforeDate: bestBeforeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(bestBeforeDate),
      processingType: Value(processingType),
      notes: Value(notes),
      originNote: Value(originNote),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory HoneyBookEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HoneyBookEntry(
      id: serializer.fromJson<String>(json['id']),
      runningNumber: serializer.fromJson<String>(json['runningNumber']),
      harvestDate: serializer.fromJson<DateTime>(json['harvestDate']),
      extractionLocation: serializer.fromJson<String>(
        json['extractionLocation'],
      ),
      honeyType: serializer.fromJson<String>(json['honeyType']),
      waterContentPercent: serializer.fromJson<double?>(
        json['waterContentPercent'],
      ),
      amountKg: serializer.fromJson<double>(json['amountKg']),
      bottledAt: serializer.fromJson<DateTime?>(json['bottledAt']),
      labelNumberFrom: serializer.fromJson<String>(json['labelNumberFrom']),
      labelNumberTo: serializer.fromJson<String>(json['labelNumberTo']),
      batchNumber: serializer.fromJson<String>(json['batchNumber']),
      bestBeforeDate: serializer.fromJson<DateTime?>(json['bestBeforeDate']),
      processingType: serializer.fromJson<String>(json['processingType']),
      notes: serializer.fromJson<String>(json['notes']),
      originNote: serializer.fromJson<String>(json['originNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'runningNumber': serializer.toJson<String>(runningNumber),
      'harvestDate': serializer.toJson<DateTime>(harvestDate),
      'extractionLocation': serializer.toJson<String>(extractionLocation),
      'honeyType': serializer.toJson<String>(honeyType),
      'waterContentPercent': serializer.toJson<double?>(waterContentPercent),
      'amountKg': serializer.toJson<double>(amountKg),
      'bottledAt': serializer.toJson<DateTime?>(bottledAt),
      'labelNumberFrom': serializer.toJson<String>(labelNumberFrom),
      'labelNumberTo': serializer.toJson<String>(labelNumberTo),
      'batchNumber': serializer.toJson<String>(batchNumber),
      'bestBeforeDate': serializer.toJson<DateTime?>(bestBeforeDate),
      'processingType': serializer.toJson<String>(processingType),
      'notes': serializer.toJson<String>(notes),
      'originNote': serializer.toJson<String>(originNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  HoneyBookEntry copyWith({
    String? id,
    String? runningNumber,
    DateTime? harvestDate,
    String? extractionLocation,
    String? honeyType,
    Value<double?> waterContentPercent = const Value.absent(),
    double? amountKg,
    Value<DateTime?> bottledAt = const Value.absent(),
    String? labelNumberFrom,
    String? labelNumberTo,
    String? batchNumber,
    Value<DateTime?> bestBeforeDate = const Value.absent(),
    String? processingType,
    String? notes,
    String? originNote,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => HoneyBookEntry(
    id: id ?? this.id,
    runningNumber: runningNumber ?? this.runningNumber,
    harvestDate: harvestDate ?? this.harvestDate,
    extractionLocation: extractionLocation ?? this.extractionLocation,
    honeyType: honeyType ?? this.honeyType,
    waterContentPercent: waterContentPercent.present
        ? waterContentPercent.value
        : this.waterContentPercent,
    amountKg: amountKg ?? this.amountKg,
    bottledAt: bottledAt.present ? bottledAt.value : this.bottledAt,
    labelNumberFrom: labelNumberFrom ?? this.labelNumberFrom,
    labelNumberTo: labelNumberTo ?? this.labelNumberTo,
    batchNumber: batchNumber ?? this.batchNumber,
    bestBeforeDate: bestBeforeDate.present
        ? bestBeforeDate.value
        : this.bestBeforeDate,
    processingType: processingType ?? this.processingType,
    notes: notes ?? this.notes,
    originNote: originNote ?? this.originNote,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  HoneyBookEntry copyWithCompanion(HoneyBookEntriesCompanion data) {
    return HoneyBookEntry(
      id: data.id.present ? data.id.value : this.id,
      runningNumber: data.runningNumber.present
          ? data.runningNumber.value
          : this.runningNumber,
      harvestDate: data.harvestDate.present
          ? data.harvestDate.value
          : this.harvestDate,
      extractionLocation: data.extractionLocation.present
          ? data.extractionLocation.value
          : this.extractionLocation,
      honeyType: data.honeyType.present ? data.honeyType.value : this.honeyType,
      waterContentPercent: data.waterContentPercent.present
          ? data.waterContentPercent.value
          : this.waterContentPercent,
      amountKg: data.amountKg.present ? data.amountKg.value : this.amountKg,
      bottledAt: data.bottledAt.present ? data.bottledAt.value : this.bottledAt,
      labelNumberFrom: data.labelNumberFrom.present
          ? data.labelNumberFrom.value
          : this.labelNumberFrom,
      labelNumberTo: data.labelNumberTo.present
          ? data.labelNumberTo.value
          : this.labelNumberTo,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      bestBeforeDate: data.bestBeforeDate.present
          ? data.bestBeforeDate.value
          : this.bestBeforeDate,
      processingType: data.processingType.present
          ? data.processingType.value
          : this.processingType,
      notes: data.notes.present ? data.notes.value : this.notes,
      originNote: data.originNote.present
          ? data.originNote.value
          : this.originNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HoneyBookEntry(')
          ..write('id: $id, ')
          ..write('runningNumber: $runningNumber, ')
          ..write('harvestDate: $harvestDate, ')
          ..write('extractionLocation: $extractionLocation, ')
          ..write('honeyType: $honeyType, ')
          ..write('waterContentPercent: $waterContentPercent, ')
          ..write('amountKg: $amountKg, ')
          ..write('bottledAt: $bottledAt, ')
          ..write('labelNumberFrom: $labelNumberFrom, ')
          ..write('labelNumberTo: $labelNumberTo, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('bestBeforeDate: $bestBeforeDate, ')
          ..write('processingType: $processingType, ')
          ..write('notes: $notes, ')
          ..write('originNote: $originNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    runningNumber,
    harvestDate,
    extractionLocation,
    honeyType,
    waterContentPercent,
    amountKg,
    bottledAt,
    labelNumberFrom,
    labelNumberTo,
    batchNumber,
    bestBeforeDate,
    processingType,
    notes,
    originNote,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HoneyBookEntry &&
          other.id == this.id &&
          other.runningNumber == this.runningNumber &&
          other.harvestDate == this.harvestDate &&
          other.extractionLocation == this.extractionLocation &&
          other.honeyType == this.honeyType &&
          other.waterContentPercent == this.waterContentPercent &&
          other.amountKg == this.amountKg &&
          other.bottledAt == this.bottledAt &&
          other.labelNumberFrom == this.labelNumberFrom &&
          other.labelNumberTo == this.labelNumberTo &&
          other.batchNumber == this.batchNumber &&
          other.bestBeforeDate == this.bestBeforeDate &&
          other.processingType == this.processingType &&
          other.notes == this.notes &&
          other.originNote == this.originNote &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HoneyBookEntriesCompanion extends UpdateCompanion<HoneyBookEntry> {
  final Value<String> id;
  final Value<String> runningNumber;
  final Value<DateTime> harvestDate;
  final Value<String> extractionLocation;
  final Value<String> honeyType;
  final Value<double?> waterContentPercent;
  final Value<double> amountKg;
  final Value<DateTime?> bottledAt;
  final Value<String> labelNumberFrom;
  final Value<String> labelNumberTo;
  final Value<String> batchNumber;
  final Value<DateTime?> bestBeforeDate;
  final Value<String> processingType;
  final Value<String> notes;
  final Value<String> originNote;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const HoneyBookEntriesCompanion({
    this.id = const Value.absent(),
    this.runningNumber = const Value.absent(),
    this.harvestDate = const Value.absent(),
    this.extractionLocation = const Value.absent(),
    this.honeyType = const Value.absent(),
    this.waterContentPercent = const Value.absent(),
    this.amountKg = const Value.absent(),
    this.bottledAt = const Value.absent(),
    this.labelNumberFrom = const Value.absent(),
    this.labelNumberTo = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.bestBeforeDate = const Value.absent(),
    this.processingType = const Value.absent(),
    this.notes = const Value.absent(),
    this.originNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HoneyBookEntriesCompanion.insert({
    required String id,
    required String runningNumber,
    required DateTime harvestDate,
    required String extractionLocation,
    required String honeyType,
    this.waterContentPercent = const Value.absent(),
    required double amountKg,
    this.bottledAt = const Value.absent(),
    this.labelNumberFrom = const Value.absent(),
    this.labelNumberTo = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.bestBeforeDate = const Value.absent(),
    required String processingType,
    this.notes = const Value.absent(),
    this.originNote = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       runningNumber = Value(runningNumber),
       harvestDate = Value(harvestDate),
       extractionLocation = Value(extractionLocation),
       honeyType = Value(honeyType),
       amountKg = Value(amountKg),
       processingType = Value(processingType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<HoneyBookEntry> custom({
    Expression<String>? id,
    Expression<String>? runningNumber,
    Expression<DateTime>? harvestDate,
    Expression<String>? extractionLocation,
    Expression<String>? honeyType,
    Expression<double>? waterContentPercent,
    Expression<double>? amountKg,
    Expression<DateTime>? bottledAt,
    Expression<String>? labelNumberFrom,
    Expression<String>? labelNumberTo,
    Expression<String>? batchNumber,
    Expression<DateTime>? bestBeforeDate,
    Expression<String>? processingType,
    Expression<String>? notes,
    Expression<String>? originNote,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (runningNumber != null) 'running_number': runningNumber,
      if (harvestDate != null) 'harvest_date': harvestDate,
      if (extractionLocation != null) 'extraction_location': extractionLocation,
      if (honeyType != null) 'honey_type': honeyType,
      if (waterContentPercent != null)
        'water_content_percent': waterContentPercent,
      if (amountKg != null) 'amount_kg': amountKg,
      if (bottledAt != null) 'bottled_at': bottledAt,
      if (labelNumberFrom != null) 'label_number_from': labelNumberFrom,
      if (labelNumberTo != null) 'label_number_to': labelNumberTo,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (bestBeforeDate != null) 'best_before_date': bestBeforeDate,
      if (processingType != null) 'processing_type': processingType,
      if (notes != null) 'notes': notes,
      if (originNote != null) 'origin_note': originNote,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HoneyBookEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? runningNumber,
    Value<DateTime>? harvestDate,
    Value<String>? extractionLocation,
    Value<String>? honeyType,
    Value<double?>? waterContentPercent,
    Value<double>? amountKg,
    Value<DateTime?>? bottledAt,
    Value<String>? labelNumberFrom,
    Value<String>? labelNumberTo,
    Value<String>? batchNumber,
    Value<DateTime?>? bestBeforeDate,
    Value<String>? processingType,
    Value<String>? notes,
    Value<String>? originNote,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return HoneyBookEntriesCompanion(
      id: id ?? this.id,
      runningNumber: runningNumber ?? this.runningNumber,
      harvestDate: harvestDate ?? this.harvestDate,
      extractionLocation: extractionLocation ?? this.extractionLocation,
      honeyType: honeyType ?? this.honeyType,
      waterContentPercent: waterContentPercent ?? this.waterContentPercent,
      amountKg: amountKg ?? this.amountKg,
      bottledAt: bottledAt ?? this.bottledAt,
      labelNumberFrom: labelNumberFrom ?? this.labelNumberFrom,
      labelNumberTo: labelNumberTo ?? this.labelNumberTo,
      batchNumber: batchNumber ?? this.batchNumber,
      bestBeforeDate: bestBeforeDate ?? this.bestBeforeDate,
      processingType: processingType ?? this.processingType,
      notes: notes ?? this.notes,
      originNote: originNote ?? this.originNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (runningNumber.present) {
      map['running_number'] = Variable<String>(runningNumber.value);
    }
    if (harvestDate.present) {
      map['harvest_date'] = Variable<DateTime>(harvestDate.value);
    }
    if (extractionLocation.present) {
      map['extraction_location'] = Variable<String>(extractionLocation.value);
    }
    if (honeyType.present) {
      map['honey_type'] = Variable<String>(honeyType.value);
    }
    if (waterContentPercent.present) {
      map['water_content_percent'] = Variable<double>(
        waterContentPercent.value,
      );
    }
    if (amountKg.present) {
      map['amount_kg'] = Variable<double>(amountKg.value);
    }
    if (bottledAt.present) {
      map['bottled_at'] = Variable<DateTime>(bottledAt.value);
    }
    if (labelNumberFrom.present) {
      map['label_number_from'] = Variable<String>(labelNumberFrom.value);
    }
    if (labelNumberTo.present) {
      map['label_number_to'] = Variable<String>(labelNumberTo.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (bestBeforeDate.present) {
      map['best_before_date'] = Variable<DateTime>(bestBeforeDate.value);
    }
    if (processingType.present) {
      map['processing_type'] = Variable<String>(processingType.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (originNote.present) {
      map['origin_note'] = Variable<String>(originNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HoneyBookEntriesCompanion(')
          ..write('id: $id, ')
          ..write('runningNumber: $runningNumber, ')
          ..write('harvestDate: $harvestDate, ')
          ..write('extractionLocation: $extractionLocation, ')
          ..write('honeyType: $honeyType, ')
          ..write('waterContentPercent: $waterContentPercent, ')
          ..write('amountKg: $amountKg, ')
          ..write('bottledAt: $bottledAt, ')
          ..write('labelNumberFrom: $labelNumberFrom, ')
          ..write('labelNumberTo: $labelNumberTo, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('bestBeforeDate: $bestBeforeDate, ')
          ..write('processingType: $processingType, ')
          ..write('notes: $notes, ')
          ..write('originNote: $originNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ApiariesTable apiaries = $ApiariesTable(this);
  late final $HivesTable hives = $HivesTable(this);
  late final $InspectionsTable inspections = $InspectionsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $InspectionPhotosTable inspectionPhotos = $InspectionPhotosTable(
    this,
  );
  late final $PhotoAttachmentsTable photoAttachments = $PhotoAttachmentsTable(
    this,
  );
  late final $HoneyBookEntriesTable honeyBookEntries = $HoneyBookEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    apiaries,
    hives,
    inspections,
    tasks,
    inspectionPhotos,
    photoAttachments,
    honeyBookEntries,
  ];
}

typedef $$ApiariesTableCreateCompanionBuilder =
    ApiariesCompanion Function({
      required String id,
      required String name,
      required String location,
      Value<String> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ApiariesTableUpdateCompanionBuilder =
    ApiariesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> location,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ApiariesTableReferences
    extends BaseReferences<_$AppDatabase, $ApiariesTable, Apiary> {
  $$ApiariesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HivesTable, List<Hive>> _hivesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.hives,
    aliasName: $_aliasNameGenerator(db.apiaries.id, db.hives.apiaryId),
  );

  $$HivesTableProcessedTableManager get hivesRefs {
    final manager = $$HivesTableTableManager(
      $_db,
      $_db.hives,
    ).filter((f) => f.apiaryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_hivesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ApiariesTableFilterComposer
    extends Composer<_$AppDatabase, $ApiariesTable> {
  $$ApiariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> hivesRefs(
    Expression<bool> Function($$HivesTableFilterComposer f) f,
  ) {
    final $$HivesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.apiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableFilterComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ApiariesTableOrderingComposer
    extends Composer<_$AppDatabase, $ApiariesTable> {
  $$ApiariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApiariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApiariesTable> {
  $$ApiariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> hivesRefs<T extends Object>(
    Expression<T> Function($$HivesTableAnnotationComposer a) f,
  ) {
    final $$HivesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.apiaryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableAnnotationComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ApiariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApiariesTable,
          Apiary,
          $$ApiariesTableFilterComposer,
          $$ApiariesTableOrderingComposer,
          $$ApiariesTableAnnotationComposer,
          $$ApiariesTableCreateCompanionBuilder,
          $$ApiariesTableUpdateCompanionBuilder,
          (Apiary, $$ApiariesTableReferences),
          Apiary,
          PrefetchHooks Function({bool hivesRefs})
        > {
  $$ApiariesTableTableManager(_$AppDatabase db, $ApiariesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApiariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApiariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApiariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApiariesCompanion(
                id: id,
                name: name,
                location: location,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String location,
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ApiariesCompanion.insert(
                id: id,
                name: name,
                location: location,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ApiariesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({hivesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (hivesRefs) db.hives],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (hivesRefs)
                    await $_getPrefetchedData<Apiary, $ApiariesTable, Hive>(
                      currentTable: table,
                      referencedTable: $$ApiariesTableReferences
                          ._hivesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ApiariesTableReferences(db, table, p0).hivesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.apiaryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ApiariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApiariesTable,
      Apiary,
      $$ApiariesTableFilterComposer,
      $$ApiariesTableOrderingComposer,
      $$ApiariesTableAnnotationComposer,
      $$ApiariesTableCreateCompanionBuilder,
      $$ApiariesTableUpdateCompanionBuilder,
      (Apiary, $$ApiariesTableReferences),
      Apiary,
      PrefetchHooks Function({bool hivesRefs})
    >;
typedef $$HivesTableCreateCompanionBuilder =
    HivesCompanion Function({
      required String id,
      required String apiaryId,
      required String hiveNumber,
      Value<String> name,
      Value<String> hiveType,
      required int queenYear,
      required String queenColor,
      Value<String> queenOrigin,
      required String status,
      Value<String> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HivesTableUpdateCompanionBuilder =
    HivesCompanion Function({
      Value<String> id,
      Value<String> apiaryId,
      Value<String> hiveNumber,
      Value<String> name,
      Value<String> hiveType,
      Value<int> queenYear,
      Value<String> queenColor,
      Value<String> queenOrigin,
      Value<String> status,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$HivesTableReferences
    extends BaseReferences<_$AppDatabase, $HivesTable, Hive> {
  $$HivesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ApiariesTable _apiaryIdTable(_$AppDatabase db) => db.apiaries
      .createAlias($_aliasNameGenerator(db.hives.apiaryId, db.apiaries.id));

  $$ApiariesTableProcessedTableManager get apiaryId {
    final $_column = $_itemColumn<String>('apiary_id')!;

    final manager = $$ApiariesTableTableManager(
      $_db,
      $_db.apiaries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_apiaryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InspectionsTable, List<Inspection>>
  _inspectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inspections,
    aliasName: $_aliasNameGenerator(db.hives.id, db.inspections.hiveId),
  );

  $$InspectionsTableProcessedTableManager get inspectionsRefs {
    final manager = $$InspectionsTableTableManager(
      $_db,
      $_db.inspections,
    ).filter((f) => f.hiveId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inspectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: $_aliasNameGenerator(db.hives.id, db.tasks.hiveId),
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.hiveId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HivesTableFilterComposer extends Composer<_$AppDatabase, $HivesTable> {
  $$HivesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hiveNumber => $composableBuilder(
    column: $table.hiveNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hiveType => $composableBuilder(
    column: $table.hiveType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get queenYear => $composableBuilder(
    column: $table.queenYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queenColor => $composableBuilder(
    column: $table.queenColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queenOrigin => $composableBuilder(
    column: $table.queenOrigin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ApiariesTableFilterComposer get apiaryId {
    final $$ApiariesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiaryId,
      referencedTable: $db.apiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiariesTableFilterComposer(
            $db: $db,
            $table: $db.apiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> inspectionsRefs(
    Expression<bool> Function($$InspectionsTableFilterComposer f) f,
  ) {
    final $$InspectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspections,
      getReferencedColumn: (t) => t.hiveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionsTableFilterComposer(
            $db: $db,
            $table: $db.inspections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.hiveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HivesTableOrderingComposer
    extends Composer<_$AppDatabase, $HivesTable> {
  $$HivesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hiveNumber => $composableBuilder(
    column: $table.hiveNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hiveType => $composableBuilder(
    column: $table.hiveType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get queenYear => $composableBuilder(
    column: $table.queenYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queenColor => $composableBuilder(
    column: $table.queenColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queenOrigin => $composableBuilder(
    column: $table.queenOrigin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ApiariesTableOrderingComposer get apiaryId {
    final $$ApiariesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiaryId,
      referencedTable: $db.apiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiariesTableOrderingComposer(
            $db: $db,
            $table: $db.apiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HivesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HivesTable> {
  $$HivesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hiveNumber => $composableBuilder(
    column: $table.hiveNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get hiveType =>
      $composableBuilder(column: $table.hiveType, builder: (column) => column);

  GeneratedColumn<int> get queenYear =>
      $composableBuilder(column: $table.queenYear, builder: (column) => column);

  GeneratedColumn<String> get queenColor => $composableBuilder(
    column: $table.queenColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get queenOrigin => $composableBuilder(
    column: $table.queenOrigin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ApiariesTableAnnotationComposer get apiaryId {
    final $$ApiariesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.apiaryId,
      referencedTable: $db.apiaries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ApiariesTableAnnotationComposer(
            $db: $db,
            $table: $db.apiaries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> inspectionsRefs<T extends Object>(
    Expression<T> Function($$InspectionsTableAnnotationComposer a) f,
  ) {
    final $$InspectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspections,
      getReferencedColumn: (t) => t.hiveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.inspections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.hiveId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HivesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HivesTable,
          Hive,
          $$HivesTableFilterComposer,
          $$HivesTableOrderingComposer,
          $$HivesTableAnnotationComposer,
          $$HivesTableCreateCompanionBuilder,
          $$HivesTableUpdateCompanionBuilder,
          (Hive, $$HivesTableReferences),
          Hive,
          PrefetchHooks Function({
            bool apiaryId,
            bool inspectionsRefs,
            bool tasksRefs,
          })
        > {
  $$HivesTableTableManager(_$AppDatabase db, $HivesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HivesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HivesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HivesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> apiaryId = const Value.absent(),
                Value<String> hiveNumber = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> hiveType = const Value.absent(),
                Value<int> queenYear = const Value.absent(),
                Value<String> queenColor = const Value.absent(),
                Value<String> queenOrigin = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HivesCompanion(
                id: id,
                apiaryId: apiaryId,
                hiveNumber: hiveNumber,
                name: name,
                hiveType: hiveType,
                queenYear: queenYear,
                queenColor: queenColor,
                queenOrigin: queenOrigin,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String apiaryId,
                required String hiveNumber,
                Value<String> name = const Value.absent(),
                Value<String> hiveType = const Value.absent(),
                required int queenYear,
                required String queenColor,
                Value<String> queenOrigin = const Value.absent(),
                required String status,
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HivesCompanion.insert(
                id: id,
                apiaryId: apiaryId,
                hiveNumber: hiveNumber,
                name: name,
                hiveType: hiveType,
                queenYear: queenYear,
                queenColor: queenColor,
                queenOrigin: queenOrigin,
                status: status,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HivesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({apiaryId = false, inspectionsRefs = false, tasksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (inspectionsRefs) db.inspections,
                    if (tasksRefs) db.tasks,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (apiaryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.apiaryId,
                                    referencedTable: $$HivesTableReferences
                                        ._apiaryIdTable(db),
                                    referencedColumn: $$HivesTableReferences
                                        ._apiaryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (inspectionsRefs)
                        await $_getPrefetchedData<
                          Hive,
                          $HivesTable,
                          Inspection
                        >(
                          currentTable: table,
                          referencedTable: $$HivesTableReferences
                              ._inspectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HivesTableReferences(
                                db,
                                table,
                                p0,
                              ).inspectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.hiveId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<Hive, $HivesTable, Task>(
                          currentTable: table,
                          referencedTable: $$HivesTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HivesTableReferences(db, table, p0).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.hiveId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$HivesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HivesTable,
      Hive,
      $$HivesTableFilterComposer,
      $$HivesTableOrderingComposer,
      $$HivesTableAnnotationComposer,
      $$HivesTableCreateCompanionBuilder,
      $$HivesTableUpdateCompanionBuilder,
      (Hive, $$HivesTableReferences),
      Hive,
      PrefetchHooks Function({
        bool apiaryId,
        bool inspectionsRefs,
        bool tasksRefs,
      })
    >;
typedef $$InspectionsTableCreateCompanionBuilder =
    InspectionsCompanion Function({
      required String id,
      required String hiveId,
      required DateTime inspectionDateTime,
      required String mood,
      required bool queenSeen,
      required String combPosition,
      required bool queenCellsSeen,
      required bool swarmCellsSeen,
      required bool emergencyCellsSeen,
      required bool cellsRemoved,
      required String droneFrameFillLevel,
      required bool droneFrameRemoved,
      required bool droneFrameRenewed,
      required int colonyStrength,
      required int broodFrames,
      required String foodStatus,
      required String queenColor,
      required bool queenExcluderInserted,
      required int honeySupersCount,
      required String honeySuperFillLevel,
      required String honeyCappingStatus,
      Value<double?> honeyWaterContent,
      required bool beeEscapeInserted,
      required bool varroaTreatmentDone,
      required String varroaTreatmentType,
      required bool feedingDone,
      required String feedingType,
      Value<double?> feedingAmount,
      Value<String> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$InspectionsTableUpdateCompanionBuilder =
    InspectionsCompanion Function({
      Value<String> id,
      Value<String> hiveId,
      Value<DateTime> inspectionDateTime,
      Value<String> mood,
      Value<bool> queenSeen,
      Value<String> combPosition,
      Value<bool> queenCellsSeen,
      Value<bool> swarmCellsSeen,
      Value<bool> emergencyCellsSeen,
      Value<bool> cellsRemoved,
      Value<String> droneFrameFillLevel,
      Value<bool> droneFrameRemoved,
      Value<bool> droneFrameRenewed,
      Value<int> colonyStrength,
      Value<int> broodFrames,
      Value<String> foodStatus,
      Value<String> queenColor,
      Value<bool> queenExcluderInserted,
      Value<int> honeySupersCount,
      Value<String> honeySuperFillLevel,
      Value<String> honeyCappingStatus,
      Value<double?> honeyWaterContent,
      Value<bool> beeEscapeInserted,
      Value<bool> varroaTreatmentDone,
      Value<String> varroaTreatmentType,
      Value<bool> feedingDone,
      Value<String> feedingType,
      Value<double?> feedingAmount,
      Value<String> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$InspectionsTableReferences
    extends BaseReferences<_$AppDatabase, $InspectionsTable, Inspection> {
  $$InspectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HivesTable _hiveIdTable(_$AppDatabase db) => db.hives.createAlias(
    $_aliasNameGenerator(db.inspections.hiveId, db.hives.id),
  );

  $$HivesTableProcessedTableManager get hiveId {
    final $_column = $_itemColumn<String>('hive_id')!;

    final manager = $$HivesTableTableManager(
      $_db,
      $_db.hives,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_hiveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InspectionPhotosTable, List<InspectionPhoto>>
  _inspectionPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.inspectionPhotos,
    aliasName: $_aliasNameGenerator(
      db.inspections.id,
      db.inspectionPhotos.inspectionId,
    ),
  );

  $$InspectionPhotosTableProcessedTableManager get inspectionPhotosRefs {
    final manager = $$InspectionPhotosTableTableManager(
      $_db,
      $_db.inspectionPhotos,
    ).filter((f) => f.inspectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inspectionPhotosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InspectionsTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get inspectionDateTime => $composableBuilder(
    column: $table.inspectionDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get queenSeen => $composableBuilder(
    column: $table.queenSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get combPosition => $composableBuilder(
    column: $table.combPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get queenCellsSeen => $composableBuilder(
    column: $table.queenCellsSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get swarmCellsSeen => $composableBuilder(
    column: $table.swarmCellsSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get emergencyCellsSeen => $composableBuilder(
    column: $table.emergencyCellsSeen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cellsRemoved => $composableBuilder(
    column: $table.cellsRemoved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get droneFrameFillLevel => $composableBuilder(
    column: $table.droneFrameFillLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get droneFrameRemoved => $composableBuilder(
    column: $table.droneFrameRemoved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get droneFrameRenewed => $composableBuilder(
    column: $table.droneFrameRenewed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colonyStrength => $composableBuilder(
    column: $table.colonyStrength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get broodFrames => $composableBuilder(
    column: $table.broodFrames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodStatus => $composableBuilder(
    column: $table.foodStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get queenColor => $composableBuilder(
    column: $table.queenColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get queenExcluderInserted => $composableBuilder(
    column: $table.queenExcluderInserted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get honeySupersCount => $composableBuilder(
    column: $table.honeySupersCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get honeySuperFillLevel => $composableBuilder(
    column: $table.honeySuperFillLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get honeyCappingStatus => $composableBuilder(
    column: $table.honeyCappingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get honeyWaterContent => $composableBuilder(
    column: $table.honeyWaterContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get beeEscapeInserted => $composableBuilder(
    column: $table.beeEscapeInserted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get varroaTreatmentDone => $composableBuilder(
    column: $table.varroaTreatmentDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get varroaTreatmentType => $composableBuilder(
    column: $table.varroaTreatmentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get feedingDone => $composableBuilder(
    column: $table.feedingDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedingType => $composableBuilder(
    column: $table.feedingType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get feedingAmount => $composableBuilder(
    column: $table.feedingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HivesTableFilterComposer get hiveId {
    final $$HivesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hiveId,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableFilterComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> inspectionPhotosRefs(
    Expression<bool> Function($$InspectionPhotosTableFilterComposer f) f,
  ) {
    final $$InspectionPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspectionPhotos,
      getReferencedColumn: (t) => t.inspectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionPhotosTableFilterComposer(
            $db: $db,
            $table: $db.inspectionPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InspectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get inspectionDateTime => $composableBuilder(
    column: $table.inspectionDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get queenSeen => $composableBuilder(
    column: $table.queenSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get combPosition => $composableBuilder(
    column: $table.combPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get queenCellsSeen => $composableBuilder(
    column: $table.queenCellsSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get swarmCellsSeen => $composableBuilder(
    column: $table.swarmCellsSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get emergencyCellsSeen => $composableBuilder(
    column: $table.emergencyCellsSeen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cellsRemoved => $composableBuilder(
    column: $table.cellsRemoved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get droneFrameFillLevel => $composableBuilder(
    column: $table.droneFrameFillLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get droneFrameRemoved => $composableBuilder(
    column: $table.droneFrameRemoved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get droneFrameRenewed => $composableBuilder(
    column: $table.droneFrameRenewed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colonyStrength => $composableBuilder(
    column: $table.colonyStrength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get broodFrames => $composableBuilder(
    column: $table.broodFrames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodStatus => $composableBuilder(
    column: $table.foodStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get queenColor => $composableBuilder(
    column: $table.queenColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get queenExcluderInserted => $composableBuilder(
    column: $table.queenExcluderInserted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get honeySupersCount => $composableBuilder(
    column: $table.honeySupersCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get honeySuperFillLevel => $composableBuilder(
    column: $table.honeySuperFillLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get honeyCappingStatus => $composableBuilder(
    column: $table.honeyCappingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get honeyWaterContent => $composableBuilder(
    column: $table.honeyWaterContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get beeEscapeInserted => $composableBuilder(
    column: $table.beeEscapeInserted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get varroaTreatmentDone => $composableBuilder(
    column: $table.varroaTreatmentDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get varroaTreatmentType => $composableBuilder(
    column: $table.varroaTreatmentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get feedingDone => $composableBuilder(
    column: $table.feedingDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedingType => $composableBuilder(
    column: $table.feedingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get feedingAmount => $composableBuilder(
    column: $table.feedingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HivesTableOrderingComposer get hiveId {
    final $$HivesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hiveId,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableOrderingComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InspectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionsTable> {
  $$InspectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get inspectionDateTime => $composableBuilder(
    column: $table.inspectionDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<bool> get queenSeen =>
      $composableBuilder(column: $table.queenSeen, builder: (column) => column);

  GeneratedColumn<String> get combPosition => $composableBuilder(
    column: $table.combPosition,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get queenCellsSeen => $composableBuilder(
    column: $table.queenCellsSeen,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get swarmCellsSeen => $composableBuilder(
    column: $table.swarmCellsSeen,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get emergencyCellsSeen => $composableBuilder(
    column: $table.emergencyCellsSeen,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cellsRemoved => $composableBuilder(
    column: $table.cellsRemoved,
    builder: (column) => column,
  );

  GeneratedColumn<String> get droneFrameFillLevel => $composableBuilder(
    column: $table.droneFrameFillLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get droneFrameRemoved => $composableBuilder(
    column: $table.droneFrameRemoved,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get droneFrameRenewed => $composableBuilder(
    column: $table.droneFrameRenewed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colonyStrength => $composableBuilder(
    column: $table.colonyStrength,
    builder: (column) => column,
  );

  GeneratedColumn<int> get broodFrames => $composableBuilder(
    column: $table.broodFrames,
    builder: (column) => column,
  );

  GeneratedColumn<String> get foodStatus => $composableBuilder(
    column: $table.foodStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get queenColor => $composableBuilder(
    column: $table.queenColor,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get queenExcluderInserted => $composableBuilder(
    column: $table.queenExcluderInserted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get honeySupersCount => $composableBuilder(
    column: $table.honeySupersCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get honeySuperFillLevel => $composableBuilder(
    column: $table.honeySuperFillLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get honeyCappingStatus => $composableBuilder(
    column: $table.honeyCappingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<double> get honeyWaterContent => $composableBuilder(
    column: $table.honeyWaterContent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get beeEscapeInserted => $composableBuilder(
    column: $table.beeEscapeInserted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get varroaTreatmentDone => $composableBuilder(
    column: $table.varroaTreatmentDone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get varroaTreatmentType => $composableBuilder(
    column: $table.varroaTreatmentType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get feedingDone => $composableBuilder(
    column: $table.feedingDone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get feedingType => $composableBuilder(
    column: $table.feedingType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get feedingAmount => $composableBuilder(
    column: $table.feedingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$HivesTableAnnotationComposer get hiveId {
    final $$HivesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hiveId,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableAnnotationComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> inspectionPhotosRefs<T extends Object>(
    Expression<T> Function($$InspectionPhotosTableAnnotationComposer a) f,
  ) {
    final $$InspectionPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inspectionPhotos,
      getReferencedColumn: (t) => t.inspectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.inspectionPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InspectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionsTable,
          Inspection,
          $$InspectionsTableFilterComposer,
          $$InspectionsTableOrderingComposer,
          $$InspectionsTableAnnotationComposer,
          $$InspectionsTableCreateCompanionBuilder,
          $$InspectionsTableUpdateCompanionBuilder,
          (Inspection, $$InspectionsTableReferences),
          Inspection,
          PrefetchHooks Function({bool hiveId, bool inspectionPhotosRefs})
        > {
  $$InspectionsTableTableManager(_$AppDatabase db, $InspectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> hiveId = const Value.absent(),
                Value<DateTime> inspectionDateTime = const Value.absent(),
                Value<String> mood = const Value.absent(),
                Value<bool> queenSeen = const Value.absent(),
                Value<String> combPosition = const Value.absent(),
                Value<bool> queenCellsSeen = const Value.absent(),
                Value<bool> swarmCellsSeen = const Value.absent(),
                Value<bool> emergencyCellsSeen = const Value.absent(),
                Value<bool> cellsRemoved = const Value.absent(),
                Value<String> droneFrameFillLevel = const Value.absent(),
                Value<bool> droneFrameRemoved = const Value.absent(),
                Value<bool> droneFrameRenewed = const Value.absent(),
                Value<int> colonyStrength = const Value.absent(),
                Value<int> broodFrames = const Value.absent(),
                Value<String> foodStatus = const Value.absent(),
                Value<String> queenColor = const Value.absent(),
                Value<bool> queenExcluderInserted = const Value.absent(),
                Value<int> honeySupersCount = const Value.absent(),
                Value<String> honeySuperFillLevel = const Value.absent(),
                Value<String> honeyCappingStatus = const Value.absent(),
                Value<double?> honeyWaterContent = const Value.absent(),
                Value<bool> beeEscapeInserted = const Value.absent(),
                Value<bool> varroaTreatmentDone = const Value.absent(),
                Value<String> varroaTreatmentType = const Value.absent(),
                Value<bool> feedingDone = const Value.absent(),
                Value<String> feedingType = const Value.absent(),
                Value<double?> feedingAmount = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionsCompanion(
                id: id,
                hiveId: hiveId,
                inspectionDateTime: inspectionDateTime,
                mood: mood,
                queenSeen: queenSeen,
                combPosition: combPosition,
                queenCellsSeen: queenCellsSeen,
                swarmCellsSeen: swarmCellsSeen,
                emergencyCellsSeen: emergencyCellsSeen,
                cellsRemoved: cellsRemoved,
                droneFrameFillLevel: droneFrameFillLevel,
                droneFrameRemoved: droneFrameRemoved,
                droneFrameRenewed: droneFrameRenewed,
                colonyStrength: colonyStrength,
                broodFrames: broodFrames,
                foodStatus: foodStatus,
                queenColor: queenColor,
                queenExcluderInserted: queenExcluderInserted,
                honeySupersCount: honeySupersCount,
                honeySuperFillLevel: honeySuperFillLevel,
                honeyCappingStatus: honeyCappingStatus,
                honeyWaterContent: honeyWaterContent,
                beeEscapeInserted: beeEscapeInserted,
                varroaTreatmentDone: varroaTreatmentDone,
                varroaTreatmentType: varroaTreatmentType,
                feedingDone: feedingDone,
                feedingType: feedingType,
                feedingAmount: feedingAmount,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String hiveId,
                required DateTime inspectionDateTime,
                required String mood,
                required bool queenSeen,
                required String combPosition,
                required bool queenCellsSeen,
                required bool swarmCellsSeen,
                required bool emergencyCellsSeen,
                required bool cellsRemoved,
                required String droneFrameFillLevel,
                required bool droneFrameRemoved,
                required bool droneFrameRenewed,
                required int colonyStrength,
                required int broodFrames,
                required String foodStatus,
                required String queenColor,
                required bool queenExcluderInserted,
                required int honeySupersCount,
                required String honeySuperFillLevel,
                required String honeyCappingStatus,
                Value<double?> honeyWaterContent = const Value.absent(),
                required bool beeEscapeInserted,
                required bool varroaTreatmentDone,
                required String varroaTreatmentType,
                required bool feedingDone,
                required String feedingType,
                Value<double?> feedingAmount = const Value.absent(),
                Value<String> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => InspectionsCompanion.insert(
                id: id,
                hiveId: hiveId,
                inspectionDateTime: inspectionDateTime,
                mood: mood,
                queenSeen: queenSeen,
                combPosition: combPosition,
                queenCellsSeen: queenCellsSeen,
                swarmCellsSeen: swarmCellsSeen,
                emergencyCellsSeen: emergencyCellsSeen,
                cellsRemoved: cellsRemoved,
                droneFrameFillLevel: droneFrameFillLevel,
                droneFrameRemoved: droneFrameRemoved,
                droneFrameRenewed: droneFrameRenewed,
                colonyStrength: colonyStrength,
                broodFrames: broodFrames,
                foodStatus: foodStatus,
                queenColor: queenColor,
                queenExcluderInserted: queenExcluderInserted,
                honeySupersCount: honeySupersCount,
                honeySuperFillLevel: honeySuperFillLevel,
                honeyCappingStatus: honeyCappingStatus,
                honeyWaterContent: honeyWaterContent,
                beeEscapeInserted: beeEscapeInserted,
                varroaTreatmentDone: varroaTreatmentDone,
                varroaTreatmentType: varroaTreatmentType,
                feedingDone: feedingDone,
                feedingType: feedingType,
                feedingAmount: feedingAmount,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InspectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({hiveId = false, inspectionPhotosRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (inspectionPhotosRefs) db.inspectionPhotos,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (hiveId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.hiveId,
                                    referencedTable:
                                        $$InspectionsTableReferences
                                            ._hiveIdTable(db),
                                    referencedColumn:
                                        $$InspectionsTableReferences
                                            ._hiveIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (inspectionPhotosRefs)
                        await $_getPrefetchedData<
                          Inspection,
                          $InspectionsTable,
                          InspectionPhoto
                        >(
                          currentTable: table,
                          referencedTable: $$InspectionsTableReferences
                              ._inspectionPhotosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InspectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).inspectionPhotosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.inspectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InspectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionsTable,
      Inspection,
      $$InspectionsTableFilterComposer,
      $$InspectionsTableOrderingComposer,
      $$InspectionsTableAnnotationComposer,
      $$InspectionsTableCreateCompanionBuilder,
      $$InspectionsTableUpdateCompanionBuilder,
      (Inspection, $$InspectionsTableReferences),
      Inspection,
      PrefetchHooks Function({bool hiveId, bool inspectionPhotosRefs})
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      required String id,
      required String hiveId,
      required String title,
      Value<String> description,
      required String category,
      required DateTime dueDateTime,
      required String priority,
      required String status,
      required DateTime createdAt,
      Value<DateTime?> completedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<String> hiveId,
      Value<String> title,
      Value<String> description,
      Value<String> category,
      Value<DateTime> dueDateTime,
      Value<String> priority,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> completedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HivesTable _hiveIdTable(_$AppDatabase db) =>
      db.hives.createAlias($_aliasNameGenerator(db.tasks.hiveId, db.hives.id));

  $$HivesTableProcessedTableManager get hiveId {
    final $_column = $_itemColumn<String>('hive_id')!;

    final manager = $$HivesTableTableManager(
      $_db,
      $_db.hives,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_hiveIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDateTime => $composableBuilder(
    column: $table.dueDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HivesTableFilterComposer get hiveId {
    final $$HivesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hiveId,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableFilterComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDateTime => $composableBuilder(
    column: $table.dueDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HivesTableOrderingComposer get hiveId {
    final $$HivesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hiveId,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableOrderingComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDateTime => $composableBuilder(
    column: $table.dueDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$HivesTableAnnotationComposer get hiveId {
    final $$HivesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.hiveId,
      referencedTable: $db.hives,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HivesTableAnnotationComposer(
            $db: $db,
            $table: $db.hives,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool hiveId})
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> hiveId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> dueDateTime = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                hiveId: hiveId,
                title: title,
                description: description,
                category: category,
                dueDateTime: dueDateTime,
                priority: priority,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String hiveId,
                required String title,
                Value<String> description = const Value.absent(),
                required String category,
                required DateTime dueDateTime,
                required String priority,
                required String status,
                required DateTime createdAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                hiveId: hiveId,
                title: title,
                description: description,
                category: category,
                dueDateTime: dueDateTime,
                priority: priority,
                status: status,
                createdAt: createdAt,
                completedAt: completedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({hiveId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (hiveId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.hiveId,
                                referencedTable: $$TasksTableReferences
                                    ._hiveIdTable(db),
                                referencedColumn: $$TasksTableReferences
                                    ._hiveIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool hiveId})
    >;
typedef $$InspectionPhotosTableCreateCompanionBuilder =
    InspectionPhotosCompanion Function({
      required String id,
      required String inspectionId,
      required String localPath,
      required String originalFilename,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$InspectionPhotosTableUpdateCompanionBuilder =
    InspectionPhotosCompanion Function({
      Value<String> id,
      Value<String> inspectionId,
      Value<String> localPath,
      Value<String> originalFilename,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InspectionPhotosTableReferences
    extends
        BaseReferences<_$AppDatabase, $InspectionPhotosTable, InspectionPhoto> {
  $$InspectionPhotosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InspectionsTable _inspectionIdTable(_$AppDatabase db) =>
      db.inspections.createAlias(
        $_aliasNameGenerator(
          db.inspectionPhotos.inspectionId,
          db.inspections.id,
        ),
      );

  $$InspectionsTableProcessedTableManager get inspectionId {
    final $_column = $_itemColumn<String>('inspection_id')!;

    final manager = $$InspectionsTableTableManager(
      $_db,
      $_db.inspections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_inspectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InspectionPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $InspectionPhotosTable> {
  $$InspectionPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalFilename => $composableBuilder(
    column: $table.originalFilename,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InspectionsTableFilterComposer get inspectionId {
    final $$InspectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inspectionId,
      referencedTable: $db.inspections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionsTableFilterComposer(
            $db: $db,
            $table: $db.inspections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InspectionPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $InspectionPhotosTable> {
  $$InspectionPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalFilename => $composableBuilder(
    column: $table.originalFilename,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InspectionsTableOrderingComposer get inspectionId {
    final $$InspectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inspectionId,
      referencedTable: $db.inspections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionsTableOrderingComposer(
            $db: $db,
            $table: $db.inspections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InspectionPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $InspectionPhotosTable> {
  $$InspectionPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get originalFilename => $composableBuilder(
    column: $table.originalFilename,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InspectionsTableAnnotationComposer get inspectionId {
    final $$InspectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inspectionId,
      referencedTable: $db.inspections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InspectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.inspections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InspectionPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InspectionPhotosTable,
          InspectionPhoto,
          $$InspectionPhotosTableFilterComposer,
          $$InspectionPhotosTableOrderingComposer,
          $$InspectionPhotosTableAnnotationComposer,
          $$InspectionPhotosTableCreateCompanionBuilder,
          $$InspectionPhotosTableUpdateCompanionBuilder,
          (InspectionPhoto, $$InspectionPhotosTableReferences),
          InspectionPhoto,
          PrefetchHooks Function({bool inspectionId})
        > {
  $$InspectionPhotosTableTableManager(
    _$AppDatabase db,
    $InspectionPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InspectionPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InspectionPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InspectionPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> inspectionId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String> originalFilename = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InspectionPhotosCompanion(
                id: id,
                inspectionId: inspectionId,
                localPath: localPath,
                originalFilename: originalFilename,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String inspectionId,
                required String localPath,
                required String originalFilename,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => InspectionPhotosCompanion.insert(
                id: id,
                inspectionId: inspectionId,
                localPath: localPath,
                originalFilename: originalFilename,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InspectionPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({inspectionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (inspectionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.inspectionId,
                                referencedTable:
                                    $$InspectionPhotosTableReferences
                                        ._inspectionIdTable(db),
                                referencedColumn:
                                    $$InspectionPhotosTableReferences
                                        ._inspectionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InspectionPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InspectionPhotosTable,
      InspectionPhoto,
      $$InspectionPhotosTableFilterComposer,
      $$InspectionPhotosTableOrderingComposer,
      $$InspectionPhotosTableAnnotationComposer,
      $$InspectionPhotosTableCreateCompanionBuilder,
      $$InspectionPhotosTableUpdateCompanionBuilder,
      (InspectionPhoto, $$InspectionPhotosTableReferences),
      InspectionPhoto,
      PrefetchHooks Function({bool inspectionId})
    >;
typedef $$PhotoAttachmentsTableCreateCompanionBuilder =
    PhotoAttachmentsCompanion Function({
      required String id,
      required String localPath,
      required String filename,
      Value<String?> linkedHiveId,
      Value<String?> linkedInspectionId,
      required String type,
      required DateTime createdAt,
      Value<String> notes,
      Value<int> rowid,
    });
typedef $$PhotoAttachmentsTableUpdateCompanionBuilder =
    PhotoAttachmentsCompanion Function({
      Value<String> id,
      Value<String> localPath,
      Value<String> filename,
      Value<String?> linkedHiveId,
      Value<String?> linkedInspectionId,
      Value<String> type,
      Value<DateTime> createdAt,
      Value<String> notes,
      Value<int> rowid,
    });

class $$PhotoAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $PhotoAttachmentsTable> {
  $$PhotoAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filename => $composableBuilder(
    column: $table.filename,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedHiveId => $composableBuilder(
    column: $table.linkedHiveId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedInspectionId => $composableBuilder(
    column: $table.linkedInspectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotoAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotoAttachmentsTable> {
  $$PhotoAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filename => $composableBuilder(
    column: $table.filename,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedHiveId => $composableBuilder(
    column: $table.linkedHiveId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedInspectionId => $composableBuilder(
    column: $table.linkedInspectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotoAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotoAttachmentsTable> {
  $$PhotoAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get filename =>
      $composableBuilder(column: $table.filename, builder: (column) => column);

  GeneratedColumn<String> get linkedHiveId => $composableBuilder(
    column: $table.linkedHiveId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedInspectionId => $composableBuilder(
    column: $table.linkedInspectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$PhotoAttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotoAttachmentsTable,
          PhotoAttachment,
          $$PhotoAttachmentsTableFilterComposer,
          $$PhotoAttachmentsTableOrderingComposer,
          $$PhotoAttachmentsTableAnnotationComposer,
          $$PhotoAttachmentsTableCreateCompanionBuilder,
          $$PhotoAttachmentsTableUpdateCompanionBuilder,
          (
            PhotoAttachment,
            BaseReferences<
              _$AppDatabase,
              $PhotoAttachmentsTable,
              PhotoAttachment
            >,
          ),
          PhotoAttachment,
          PrefetchHooks Function()
        > {
  $$PhotoAttachmentsTableTableManager(
    _$AppDatabase db,
    $PhotoAttachmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotoAttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotoAttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotoAttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String> filename = const Value.absent(),
                Value<String?> linkedHiveId = const Value.absent(),
                Value<String?> linkedInspectionId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoAttachmentsCompanion(
                id: id,
                localPath: localPath,
                filename: filename,
                linkedHiveId: linkedHiveId,
                linkedInspectionId: linkedInspectionId,
                type: type,
                createdAt: createdAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localPath,
                required String filename,
                Value<String?> linkedHiveId = const Value.absent(),
                Value<String?> linkedInspectionId = const Value.absent(),
                required String type,
                required DateTime createdAt,
                Value<String> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotoAttachmentsCompanion.insert(
                id: id,
                localPath: localPath,
                filename: filename,
                linkedHiveId: linkedHiveId,
                linkedInspectionId: linkedInspectionId,
                type: type,
                createdAt: createdAt,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotoAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotoAttachmentsTable,
      PhotoAttachment,
      $$PhotoAttachmentsTableFilterComposer,
      $$PhotoAttachmentsTableOrderingComposer,
      $$PhotoAttachmentsTableAnnotationComposer,
      $$PhotoAttachmentsTableCreateCompanionBuilder,
      $$PhotoAttachmentsTableUpdateCompanionBuilder,
      (
        PhotoAttachment,
        BaseReferences<_$AppDatabase, $PhotoAttachmentsTable, PhotoAttachment>,
      ),
      PhotoAttachment,
      PrefetchHooks Function()
    >;
typedef $$HoneyBookEntriesTableCreateCompanionBuilder =
    HoneyBookEntriesCompanion Function({
      required String id,
      required String runningNumber,
      required DateTime harvestDate,
      required String extractionLocation,
      required String honeyType,
      Value<double?> waterContentPercent,
      required double amountKg,
      Value<DateTime?> bottledAt,
      Value<String> labelNumberFrom,
      Value<String> labelNumberTo,
      Value<String> batchNumber,
      Value<DateTime?> bestBeforeDate,
      required String processingType,
      Value<String> notes,
      Value<String> originNote,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$HoneyBookEntriesTableUpdateCompanionBuilder =
    HoneyBookEntriesCompanion Function({
      Value<String> id,
      Value<String> runningNumber,
      Value<DateTime> harvestDate,
      Value<String> extractionLocation,
      Value<String> honeyType,
      Value<double?> waterContentPercent,
      Value<double> amountKg,
      Value<DateTime?> bottledAt,
      Value<String> labelNumberFrom,
      Value<String> labelNumberTo,
      Value<String> batchNumber,
      Value<DateTime?> bestBeforeDate,
      Value<String> processingType,
      Value<String> notes,
      Value<String> originNote,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$HoneyBookEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $HoneyBookEntriesTable> {
  $$HoneyBookEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get runningNumber => $composableBuilder(
    column: $table.runningNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get harvestDate => $composableBuilder(
    column: $table.harvestDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractionLocation => $composableBuilder(
    column: $table.extractionLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get honeyType => $composableBuilder(
    column: $table.honeyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterContentPercent => $composableBuilder(
    column: $table.waterContentPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountKg => $composableBuilder(
    column: $table.amountKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bottledAt => $composableBuilder(
    column: $table.bottledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelNumberFrom => $composableBuilder(
    column: $table.labelNumberFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelNumberTo => $composableBuilder(
    column: $table.labelNumberTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bestBeforeDate => $composableBuilder(
    column: $table.bestBeforeDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingType => $composableBuilder(
    column: $table.processingType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originNote => $composableBuilder(
    column: $table.originNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HoneyBookEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $HoneyBookEntriesTable> {
  $$HoneyBookEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get runningNumber => $composableBuilder(
    column: $table.runningNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get harvestDate => $composableBuilder(
    column: $table.harvestDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractionLocation => $composableBuilder(
    column: $table.extractionLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get honeyType => $composableBuilder(
    column: $table.honeyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterContentPercent => $composableBuilder(
    column: $table.waterContentPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountKg => $composableBuilder(
    column: $table.amountKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bottledAt => $composableBuilder(
    column: $table.bottledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelNumberFrom => $composableBuilder(
    column: $table.labelNumberFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelNumberTo => $composableBuilder(
    column: $table.labelNumberTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bestBeforeDate => $composableBuilder(
    column: $table.bestBeforeDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingType => $composableBuilder(
    column: $table.processingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originNote => $composableBuilder(
    column: $table.originNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HoneyBookEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HoneyBookEntriesTable> {
  $$HoneyBookEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get runningNumber => $composableBuilder(
    column: $table.runningNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get harvestDate => $composableBuilder(
    column: $table.harvestDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get extractionLocation => $composableBuilder(
    column: $table.extractionLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get honeyType =>
      $composableBuilder(column: $table.honeyType, builder: (column) => column);

  GeneratedColumn<double> get waterContentPercent => $composableBuilder(
    column: $table.waterContentPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountKg =>
      $composableBuilder(column: $table.amountKg, builder: (column) => column);

  GeneratedColumn<DateTime> get bottledAt =>
      $composableBuilder(column: $table.bottledAt, builder: (column) => column);

  GeneratedColumn<String> get labelNumberFrom => $composableBuilder(
    column: $table.labelNumberFrom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelNumberTo => $composableBuilder(
    column: $table.labelNumberTo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get bestBeforeDate => $composableBuilder(
    column: $table.bestBeforeDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingType => $composableBuilder(
    column: $table.processingType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get originNote => $composableBuilder(
    column: $table.originNote,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HoneyBookEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HoneyBookEntriesTable,
          HoneyBookEntry,
          $$HoneyBookEntriesTableFilterComposer,
          $$HoneyBookEntriesTableOrderingComposer,
          $$HoneyBookEntriesTableAnnotationComposer,
          $$HoneyBookEntriesTableCreateCompanionBuilder,
          $$HoneyBookEntriesTableUpdateCompanionBuilder,
          (
            HoneyBookEntry,
            BaseReferences<
              _$AppDatabase,
              $HoneyBookEntriesTable,
              HoneyBookEntry
            >,
          ),
          HoneyBookEntry,
          PrefetchHooks Function()
        > {
  $$HoneyBookEntriesTableTableManager(
    _$AppDatabase db,
    $HoneyBookEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HoneyBookEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HoneyBookEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HoneyBookEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> runningNumber = const Value.absent(),
                Value<DateTime> harvestDate = const Value.absent(),
                Value<String> extractionLocation = const Value.absent(),
                Value<String> honeyType = const Value.absent(),
                Value<double?> waterContentPercent = const Value.absent(),
                Value<double> amountKg = const Value.absent(),
                Value<DateTime?> bottledAt = const Value.absent(),
                Value<String> labelNumberFrom = const Value.absent(),
                Value<String> labelNumberTo = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<DateTime?> bestBeforeDate = const Value.absent(),
                Value<String> processingType = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> originNote = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HoneyBookEntriesCompanion(
                id: id,
                runningNumber: runningNumber,
                harvestDate: harvestDate,
                extractionLocation: extractionLocation,
                honeyType: honeyType,
                waterContentPercent: waterContentPercent,
                amountKg: amountKg,
                bottledAt: bottledAt,
                labelNumberFrom: labelNumberFrom,
                labelNumberTo: labelNumberTo,
                batchNumber: batchNumber,
                bestBeforeDate: bestBeforeDate,
                processingType: processingType,
                notes: notes,
                originNote: originNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String runningNumber,
                required DateTime harvestDate,
                required String extractionLocation,
                required String honeyType,
                Value<double?> waterContentPercent = const Value.absent(),
                required double amountKg,
                Value<DateTime?> bottledAt = const Value.absent(),
                Value<String> labelNumberFrom = const Value.absent(),
                Value<String> labelNumberTo = const Value.absent(),
                Value<String> batchNumber = const Value.absent(),
                Value<DateTime?> bestBeforeDate = const Value.absent(),
                required String processingType,
                Value<String> notes = const Value.absent(),
                Value<String> originNote = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => HoneyBookEntriesCompanion.insert(
                id: id,
                runningNumber: runningNumber,
                harvestDate: harvestDate,
                extractionLocation: extractionLocation,
                honeyType: honeyType,
                waterContentPercent: waterContentPercent,
                amountKg: amountKg,
                bottledAt: bottledAt,
                labelNumberFrom: labelNumberFrom,
                labelNumberTo: labelNumberTo,
                batchNumber: batchNumber,
                bestBeforeDate: bestBeforeDate,
                processingType: processingType,
                notes: notes,
                originNote: originNote,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HoneyBookEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HoneyBookEntriesTable,
      HoneyBookEntry,
      $$HoneyBookEntriesTableFilterComposer,
      $$HoneyBookEntriesTableOrderingComposer,
      $$HoneyBookEntriesTableAnnotationComposer,
      $$HoneyBookEntriesTableCreateCompanionBuilder,
      $$HoneyBookEntriesTableUpdateCompanionBuilder,
      (
        HoneyBookEntry,
        BaseReferences<_$AppDatabase, $HoneyBookEntriesTable, HoneyBookEntry>,
      ),
      HoneyBookEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ApiariesTableTableManager get apiaries =>
      $$ApiariesTableTableManager(_db, _db.apiaries);
  $$HivesTableTableManager get hives =>
      $$HivesTableTableManager(_db, _db.hives);
  $$InspectionsTableTableManager get inspections =>
      $$InspectionsTableTableManager(_db, _db.inspections);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$InspectionPhotosTableTableManager get inspectionPhotos =>
      $$InspectionPhotosTableTableManager(_db, _db.inspectionPhotos);
  $$PhotoAttachmentsTableTableManager get photoAttachments =>
      $$PhotoAttachmentsTableTableManager(_db, _db.photoAttachments);
  $$HoneyBookEntriesTableTableManager get honeyBookEntries =>
      $$HoneyBookEntriesTableTableManager(_db, _db.honeyBookEntries);
}
