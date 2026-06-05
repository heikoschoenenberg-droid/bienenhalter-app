import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/models/honey_book_entry.dart';
import '../../core/services/app_repositories.dart';

class HoneyBookFormArguments {
  const HoneyBookFormArguments({this.entryId});

  final String? entryId;
}

class HoneyBookFormScreen extends StatefulWidget {
  const HoneyBookFormScreen({super.key, required this.arguments});

  final HoneyBookFormArguments? arguments;

  @override
  State<HoneyBookFormScreen> createState() => _HoneyBookFormScreenState();
}

class _HoneyBookFormScreenState extends State<HoneyBookFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _runningNumberController = TextEditingController();
  final _locationController = TextEditingController();
  final _honeyTypeController = TextEditingController();
  final _waterContentController = TextEditingController();
  final _amountController = TextEditingController();
  final _labelFromController = TextEditingController();
  final _labelToController = TextEditingController();
  final _batchNumberController = TextEditingController();
  final _originNoteController = TextEditingController();
  final _notesController = TextEditingController();

  late Future<void> _future;
  HoneyBookEntry? _existingEntry;
  DateTime _harvestDate = DateTime.now();
  DateTime? _bottledAt;
  DateTime? _bestBeforeDate;
  HoneyProcessingType _processingType = HoneyProcessingType.liquid;

  bool get _isEditing => _existingEntry != null;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  @override
  void dispose() {
    _runningNumberController.dispose();
    _locationController.dispose();
    _honeyTypeController.dispose();
    _waterContentController.dispose();
    _amountController.dispose();
    _labelFromController.dispose();
    _labelToController.dispose();
    _batchNumberController.dispose();
    _originNoteController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final entryId = widget.arguments?.entryId;
    if (entryId == null) {
      _amountController.text = '0';
      return;
    }

    final entry = await AppRepositories.instance.honeyBook
        .getHoneyBookEntryById(entryId);
    _existingEntry = entry;
    _runningNumberController.text = entry.runningNumber;
    _locationController.text = entry.extractionLocation;
    _honeyTypeController.text = entry.honeyType;
    _waterContentController.text = entry.waterContentPercent?.toString() ?? '';
    _amountController.text = entry.amountKg.toString();
    _labelFromController.text = entry.labelNumberFrom;
    _labelToController.text = entry.labelNumberTo;
    _batchNumberController.text = entry.batchNumber;
    _originNoteController.text = entry.originNote;
    _notesController.text = entry.notes;
    _harvestDate = entry.harvestDate;
    _bottledAt = entry.bottledAt;
    _bestBeforeDate = entry.bestBeforeDate;
    _processingType = entry.processingType;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Honigbuch bearbeiten' : 'Neuer Eintrag'),
      ),
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _SectionCard(
                  title: 'Schleudervorgang',
                  children: [
                    _TextField(
                      controller: _runningNumberController,
                      label: 'laufende Nummer',
                    ),
                    _DateTile(
                      label: 'Schleuderdatum',
                      value: formatDate(_harvestDate),
                      onTap: () => _pickDate(
                        initialDate: _harvestDate,
                        onPicked: (date) => setState(() => _harvestDate = date),
                      ),
                    ),
                    _TextField(
                      controller: _locationController,
                      label: 'Schleuderort',
                    ),
                    _TextField(
                      controller: _honeyTypeController,
                      label: 'Honigsorte',
                      validator: _validateRequired,
                    ),
                    _TextField(
                      controller: _originNoteController,
                      label: 'Herkunftsnotiz optional',
                      minLines: 2,
                      maxLines: 4,
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Messwerte und Menge',
                  children: [
                    _TextField(
                      controller: _waterContentController,
                      label: 'Wassergehalt in %',
                      keyboardType: TextInputType.number,
                      validator: _validateWaterContent,
                    ),
                    _TextField(
                      controller: _amountController,
                      label: 'Menge in kg',
                      keyboardType: TextInputType.number,
                      validator: _validateAmount,
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Abfuellung und Charge',
                  children: [
                    _DateTile(
                      label: 'Abfuelldatum',
                      value: _bottledAt == null
                          ? 'nicht gesetzt'
                          : formatDate(_bottledAt),
                      onTap: () => _pickDate(
                        initialDate: _bottledAt ?? _harvestDate,
                        onPicked: (date) => setState(() => _bottledAt = date),
                      ),
                      onClear: _bottledAt == null
                          ? null
                          : () => setState(() => _bottledAt = null),
                    ),
                    _TextField(
                      controller: _labelFromController,
                      label: 'Gewaehrstreifen Nr. von',
                      validator: (_) => _validateLabelRange(),
                    ),
                    _TextField(
                      controller: _labelToController,
                      label: 'Gewaehrstreifen Nr. bis',
                      validator: (_) => _validateLabelRange(),
                    ),
                    _TextField(
                      controller: _batchNumberController,
                      label: 'Losnummer',
                    ),
                    _DateTile(
                      label: 'deklariertes Haltbarkeitsdatum',
                      value: _bestBeforeDate == null
                          ? 'nicht gesetzt'
                          : formatDate(_bestBeforeDate),
                      onTap: () => _pickDate(
                        initialDate: _bestBeforeDate ?? _harvestDate,
                        onPicked: (date) =>
                            setState(() => _bestBeforeDate = date),
                      ),
                      onClear: _bestBeforeDate == null
                          ? null
                          : () => setState(() => _bestBeforeDate = null),
                    ),
                    DropdownButtonFormField<HoneyProcessingType>(
                      initialValue: _processingType,
                      decoration: const InputDecoration(
                        labelText: 'Verarbeitung',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        for (final type in HoneyProcessingType.values)
                          DropdownMenuItem(
                            value: type,
                            child: Text(type.label),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _processingType = value);
                        }
                      },
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Bemerkungen',
                  children: [
                    _TextField(
                      controller: _notesController,
                      label: 'Bemerkungen',
                      minLines: 4,
                      maxLines: 8,
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: Text(_isEditing ? 'Speichern' : 'Eintrag anlegen'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickDate({
    required DateTime initialDate,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      onPicked(pickedDate);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();
    final existingEntry = _existingEntry;
    final entry = HoneyBookEntry(
      id: existingEntry?.id ?? 'honey-${now.microsecondsSinceEpoch}',
      runningNumber: _runningNumberController.text.trim(),
      harvestDate: _harvestDate,
      extractionLocation: _locationController.text.trim(),
      honeyType: _honeyTypeController.text.trim(),
      waterContentPercent: _parseOptionalDouble(_waterContentController.text),
      amountKg: _parseDouble(_amountController.text),
      bottledAt: _bottledAt,
      labelNumberFrom: _labelFromController.text.trim(),
      labelNumberTo: _labelToController.text.trim(),
      batchNumber: _batchNumberController.text.trim(),
      bestBeforeDate: _bestBeforeDate,
      processingType: _processingType,
      notes: _notesController.text.trim(),
      originNote: _originNoteController.text.trim(),
      createdAt: existingEntry?.createdAt ?? now,
      updatedAt: now,
    );

    if (_isEditing) {
      await AppRepositories.instance.honeyBook.updateHoneyBookEntry(entry);
    } else {
      await AppRepositories.instance.honeyBook.createHoneyBookEntry(entry);
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Honigbuch-Eintrag wurde aktualisiert.'
              : 'Honigbuch-Eintrag wurde angelegt.',
        ),
      ),
    );
    Navigator.pop(context, true);
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bitte ausfuellen.';
    }
    return null;
  }

  String? _validateAmount(String? value) {
    final number = _tryParseDouble(value);
    if (number == null) {
      return 'Bitte eine Zahl eingeben.';
    }
    if (number < 0) {
      return 'Die Menge darf nicht negativ sein.';
    }
    return null;
  }

  String? _validateWaterContent(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    final number = _tryParseDouble(text);
    if (number == null) {
      return 'Bitte eine Zahl eingeben.';
    }
    if (number < 0 || number > 30) {
      return 'Bitte einen sinnvollen Wert zwischen 0 und 30 % eingeben.';
    }
    return null;
  }

  String? _validateLabelRange() {
    final from = _labelFromController.text.trim();
    final to = _labelToController.text.trim();
    if (from.isEmpty || to.isEmpty) {
      return null;
    }
    final fromNumber = int.tryParse(from);
    final toNumber = int.tryParse(to);
    if (fromNumber == null || toNumber == null) {
      return null;
    }
    if (fromNumber > toNumber) {
      return 'Von darf nicht groesser als bis sein.';
    }
    return null;
  }

  double _parseDouble(String value) {
    return _tryParseDouble(value) ?? 0;
  }

  double? _parseOptionalDouble(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return _tryParseDouble(value);
  }

  double? _tryParseDouble(String? value) {
    return double.tryParse((value ?? '').replaceAll(',', '.'));
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          alignLabelWithHint: maxLines > 1,
        ),
        validator: validator,
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({
    required this.label,
    required this.value,
    required this.onTap,
    this.onClear,
  });

  final String label;
  final String value;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.calendar_month),
      title: Text(label),
      subtitle: Text(value),
      trailing: onClear == null
          ? const Icon(Icons.edit)
          : IconButton(
              onPressed: onClear,
              icon: const Icon(Icons.clear),
              tooltip: 'Datum entfernen',
            ),
      onTap: onTap,
    );
  }
}
