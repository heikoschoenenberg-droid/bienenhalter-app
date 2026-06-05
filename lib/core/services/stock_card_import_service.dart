import 'package:flutter/foundation.dart';

import '../models/stock_card_photo_import.dart';

class StockCardImportService {
  StockCardImportService._();

  static final StockCardImportService instance = StockCardImportService._();

  final ValueNotifier<List<StockCardPhotoImport>> imports =
      ValueNotifier<List<StockCardPhotoImport>>(<StockCardPhotoImport>[]);

  void addImports(
    Iterable<({String filename, String? path, Uint8List? bytes})> files,
  ) {
    final now = DateTime.now();
    var index = 0;
    final newImports = <StockCardPhotoImport>[];
    for (final file in files) {
      newImports.add(
        StockCardPhotoImport(
          id: 'stock-card-${now.microsecondsSinceEpoch}-${index++}',
          filename: file.filename,
          path: file.path,
          hiveId: null,
          status: StockCardPhotoImportStatus.imported,
          createdAt: now,
          notes: '',
          bytes: file.bytes,
        ),
      );
    }

    imports.value = [...imports.value, ...newImports];
  }

  void assignHive({required String importId, required String? hiveId}) {
    imports.value = [
      for (final item in imports.value)
        if (item.id == importId)
          item.copyWith(
            hiveId: hiveId,
            clearHiveId: hiveId == null,
            status: hiveId == null
                ? StockCardPhotoImportStatus.imported
                : StockCardPhotoImportStatus.assigned,
          )
        else
          item,
    ];
  }

  void markDraftCreated(String importId) {
    imports.value = [
      for (final item in imports.value)
        if (item.id == importId)
          item.copyWith(status: StockCardPhotoImportStatus.draftCreated)
        else
          item,
    ];
  }

  StockCardPhotoImport? getById(String importId) {
    for (final item in imports.value) {
      if (item.id == importId) {
        return item;
      }
    }
    return null;
  }

  void removeImport(String importId) {
    imports.value = [
      for (final item in imports.value)
        if (item.id != importId) item,
    ];
  }
}
