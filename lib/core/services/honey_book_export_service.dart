import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import '../date_format.dart';
import '../models/honey_book_entry.dart';

class HoneyBookExportService {
  const HoneyBookExportService();

  Future<String?> exportExcel(List<HoneyBookEntry> entries) async {
    final sortedEntries = [...entries]..sort(_compareEntries);
    final excel = Excel.createExcel();
    final sheet = excel['Honigbuch'];
    excel.delete('Sheet1');

    sheet.appendRow([
      TextCellValue('lfd. Nr.'),
      TextCellValue('Schleuderdatum'),
      TextCellValue('Schleuderort'),
      TextCellValue('Honigsorte'),
      TextCellValue('Wassergehalt in %'),
      TextCellValue('Menge in kg'),
      TextCellValue('abgef\u00fcllt am'),
      TextCellValue('Gew\u00e4hrstreifen Nr. von'),
      TextCellValue('Gew\u00e4hrstreifen Nr. bis'),
      TextCellValue('Losnummer'),
      TextCellValue('deklariertes Haltbarkeitsdatum'),
      TextCellValue('Verarbeitung: cremig/fl\u00fcssig'),
      TextCellValue('Bemerkungen'),
    ]);

    for (final entry in sortedEntries) {
      sheet.appendRow([
        TextCellValue(entry.runningNumber),
        TextCellValue(formatDate(entry.harvestDate)),
        TextCellValue(entry.extractionLocation),
        TextCellValue(entry.honeyType),
        TextCellValue(_formatOptionalNumber(entry.waterContentPercent)),
        TextCellValue(_formatNumber(entry.amountKg)),
        TextCellValue(_formatOptionalDate(entry.bottledAt)),
        TextCellValue(entry.labelNumberFrom),
        TextCellValue(entry.labelNumberTo),
        TextCellValue(entry.batchNumber),
        TextCellValue(_formatOptionalDate(entry.bestBeforeDate)),
        TextCellValue(_formatProcessingType(entry.processingType)),
        TextCellValue(entry.notes),
      ]);
    }

    final bytes = excel.encode();
    if (bytes == null) {
      throw StateError('Excel-Datei konnte nicht erzeugt werden.');
    }

    final now = DateTime.now();
    final fileName =
        'honigbuch_export_${now.year}-${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}.xlsx';

    return FilePicker.platform.saveFile(
      dialogTitle: 'Honigbuch exportieren',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: const ['xlsx'],
      bytes: Uint8List.fromList(bytes),
    );
  }

  int _compareEntries(HoneyBookEntry a, HoneyBookEntry b) {
    final numberA = int.tryParse(a.runningNumber);
    final numberB = int.tryParse(b.runningNumber);
    if (numberA != null && numberB != null) {
      return numberB.compareTo(numberA);
    }
    return b.harvestDate.compareTo(a.harvestDate);
  }

  String _formatOptionalDate(DateTime? date) {
    return date == null ? '' : formatDate(date);
  }

  String _formatOptionalNumber(double? value) {
    return value == null ? '' : _formatNumber(value);
  }

  String _formatNumber(double value) {
    return value.toStringAsFixed(1).replaceAll('.', ',');
  }

  String _formatProcessingType(HoneyProcessingType type) {
    return switch (type) {
      HoneyProcessingType.creamy => 'cremig',
      HoneyProcessingType.liquid => 'fl\u00fcssig',
    };
  }
}
