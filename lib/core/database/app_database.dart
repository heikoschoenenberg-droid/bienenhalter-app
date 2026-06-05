import 'package:drift/drift.dart';

import 'database_connection.dart';

part 'app_database.g.dart';

class Apiaries extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get location => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Hives extends Table {
  TextColumn get id => text()();
  TextColumn get apiaryId =>
      text().customConstraint('NOT NULL REFERENCES apiaries(id)')();
  TextColumn get hiveNumber => text()();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get hiveType => text().withDefault(const Constant('Magazin'))();
  IntColumn get queenYear => integer()();
  TextColumn get queenColor => text()();
  TextColumn get queenOrigin =>
      text().withDefault(const Constant('unbekannt'))();
  TextColumn get status => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Inspections extends Table {
  TextColumn get id => text()();
  TextColumn get hiveId =>
      text().customConstraint('NOT NULL REFERENCES hives(id)')();
  DateTimeColumn get inspectionDateTime => dateTime()();
  TextColumn get mood => text()();
  BoolColumn get queenSeen => boolean()();
  TextColumn get combPosition => text()();
  BoolColumn get queenCellsSeen => boolean()();
  BoolColumn get swarmCellsSeen => boolean()();
  BoolColumn get emergencyCellsSeen => boolean()();
  BoolColumn get cellsRemoved => boolean()();
  TextColumn get droneFrameFillLevel => text()();
  BoolColumn get droneFrameRemoved => boolean()();
  BoolColumn get droneFrameRenewed => boolean()();
  IntColumn get colonyStrength => integer()();
  IntColumn get broodFrames => integer()();
  TextColumn get foodStatus => text()();
  TextColumn get queenColor => text()();
  BoolColumn get queenExcluderInserted => boolean()();
  IntColumn get honeySupersCount => integer()();
  TextColumn get honeySuperFillLevel => text()();
  TextColumn get honeyCappingStatus => text()();
  RealColumn get honeyWaterContent => real().nullable()();
  BoolColumn get beeEscapeInserted => boolean()();
  BoolColumn get varroaTreatmentDone => boolean()();
  TextColumn get varroaTreatmentType => text()();
  BoolColumn get feedingDone => boolean()();
  TextColumn get feedingType => text()();
  RealColumn get feedingAmount => real().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get hiveId =>
      text().customConstraint('NOT NULL REFERENCES hives(id)')();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get category => text()();
  DateTimeColumn get dueDateTime => dateTime()();
  TextColumn get priority => text()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class InspectionPhotos extends Table {
  TextColumn get id => text()();
  TextColumn get inspectionId =>
      text().customConstraint('NOT NULL REFERENCES inspections(id)')();
  TextColumn get localPath => text()();
  TextColumn get originalFilename => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class PhotoAttachments extends Table {
  TextColumn get id => text()();
  TextColumn get localPath => text()();
  TextColumn get filename => text()();
  TextColumn get linkedHiveId => text().nullable()();
  TextColumn get linkedInspectionId => text().nullable()();
  TextColumn get type => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get notes => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

class HoneyBookEntries extends Table {
  TextColumn get id => text()();
  TextColumn get runningNumber => text()();
  DateTimeColumn get harvestDate => dateTime()();
  TextColumn get extractionLocation => text()();
  TextColumn get honeyType => text()();
  RealColumn get waterContentPercent => real().nullable()();
  RealColumn get amountKg => real()();
  DateTimeColumn get bottledAt => dateTime().nullable()();
  TextColumn get labelNumberFrom => text().withDefault(const Constant(''))();
  TextColumn get labelNumberTo => text().withDefault(const Constant(''))();
  TextColumn get batchNumber => text().withDefault(const Constant(''))();
  DateTimeColumn get bestBeforeDate => dateTime().nullable()();
  TextColumn get processingType => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  TextColumn get originNote => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Apiaries,
    Hives,
    Inspections,
    Tasks,
    InspectionPhotos,
    PhotoAttachments,
    HoneyBookEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openDatabaseConnection());

  AppDatabase.forExecutor(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.createTable(photoAttachments);
        }
        if (from < 3) {
          await migrator.createTable(honeyBookEntries);
        }
      },
    );
  }
}
