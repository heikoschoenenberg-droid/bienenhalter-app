import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/models/photo_attachment.dart';
import '../../core/models/stock_card_photo_import.dart';
import '../../core/services/app_repositories.dart';
import '../../core/services/stock_card_import_service.dart';
import '../../core/widgets/photo_preview.dart';

class InspectionFormArguments {
  const InspectionFormArguments({
    this.hiveId,
    this.inspectionId,
    this.sourcePhotoImportId,
  });

  final String? hiveId;
  final String? inspectionId;
  final String? sourcePhotoImportId;
}

class InspectionCreateScreen extends StatefulWidget {
  const InspectionCreateScreen({super.key, required this.arguments});

  final InspectionFormArguments? arguments;

  @override
  State<InspectionCreateScreen> createState() => _InspectionCreateScreenState();
}

class _InspectionCreateScreenState extends State<InspectionCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _broodFramesController = TextEditingController(text: '6');
  final _honeySupersController = TextEditingController(text: '1');
  final _honeyWaterController = TextEditingController();
  final _feedAmountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedHiveId;
  late Future<List<Hive>> _hivesFuture;
  Inspection? _existingInspection;
  StockCardPhotoImport? _sourcePhotoImport;
  final List<PhotoAttachment> _photos = [];
  final Set<String> _removedPhotoIds = {};
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  String _mood = 'ruhig';
  bool _queenSeen = false;
  String _combPosition = 'mittig';
  bool _queenCellsSeen = false;
  bool _swarmCellsSeen = false;
  bool _emergencyCellsSeen = false;
  bool _cellsRemoved = false;
  String _droneFrameFillLevel = 'leer';
  bool _droneFrameRemoved = false;
  bool _droneFrameRenewed = false;
  int _colonyStrength = 5;
  String _feedStatus = 'ausreichend';
  String _queenColor = 'Weiss';
  bool _queenExcluderInserted = true;
  String _honeySuperFillLevel = 'gering';
  String _honeyCappingState = 'unverdeckt';
  bool _beeEscapeInserted = false;
  bool _varroaTreatmentDone = false;
  String _varroaTreatment = 'keine';
  bool _feedingDone = false;
  String _feedType = 'kein Futter';

  bool get _isEditing => _existingInspection != null;

  @override
  void initState() {
    super.initState();
    _selectedHiveId = widget.arguments?.hiveId;
    _hivesFuture = AppRepositories.instance.hives.getAll();
    _loadSourcePhotoImport();
    _loadExistingInspection();
  }

  @override
  void dispose() {
    _broodFramesController.dispose();
    _honeySupersController.dispose();
    _honeyWaterController.dispose();
    _feedAmountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadExistingInspection() async {
    final inspectionId = widget.arguments?.inspectionId;
    if (inspectionId == null) {
      return;
    }

    final inspection = await AppRepositories.instance.inspections.getById(
      inspectionId,
    );
    final photos = await AppRepositories.instance.photos.getForInspection(
      inspectionId,
    );
    _existingInspection = inspection;
    _photos
      ..clear()
      ..addAll(photos);
    _selectedHiveId = inspection.hiveId;
    _selectedDate = DateTime(
      inspection.date.year,
      inspection.date.month,
      inspection.date.day,
    );
    _selectedTime = TimeOfDay(
      hour: inspection.date.hour,
      minute: inspection.date.minute,
    );
    _mood = inspection.mood;
    _queenSeen = inspection.queenSeen;
    _combPosition = inspection.combPosition;
    _queenCellsSeen = inspection.queenCellsSeen;
    _swarmCellsSeen = inspection.swarmCellsSeen;
    _emergencyCellsSeen = inspection.emergencyCellsSeen;
    _cellsRemoved = inspection.cellsRemoved;
    _droneFrameFillLevel = inspection.droneFrameFillLevel;
    _droneFrameRemoved = inspection.droneFrameRemoved;
    _droneFrameRenewed = inspection.droneFrameRenewed;
    _colonyStrength = inspection.colonyStrength;
    _broodFramesController.text = inspection.broodFrameCount.toString();
    _feedStatus = inspection.feedStatus;
    _queenColor = inspection.queenColor;
    _queenExcluderInserted = inspection.queenExcluderInserted;
    _honeySupersController.text = inspection.honeySuperCount.toString();
    _honeySuperFillLevel = inspection.honeySuperFillLevel;
    _honeyCappingState = inspection.honeyCappingState;
    _honeyWaterController.text = inspection.honeyWaterContent?.toString() ?? '';
    _beeEscapeInserted = inspection.beeEscapeInserted;
    _varroaTreatmentDone = inspection.varroaTreatmentDone;
    _varroaTreatment = inspection.varroaTreatment;
    _feedingDone = inspection.feedingDone;
    _feedType = inspection.feedType;
    _feedAmountController.text = inspection.feedAmount?.toString() ?? '';
    _notesController.text = inspection.notes;

    if (mounted) {
      setState(() {});
    }
  }

  void _loadSourcePhotoImport() {
    final importId = widget.arguments?.sourcePhotoImportId;
    if (importId == null) {
      return;
    }

    final item = StockCardImportService.instance.getById(importId);
    if (item == null) {
      return;
    }

    _sourcePhotoImport = item;
    _photos.add(
      PhotoAttachment(
        id: 'photo-${DateTime.now().microsecondsSinceEpoch}',
        localPath: item.path ?? item.filename,
        filename: item.filename,
        linkedHiveId: item.hiveId,
        linkedInspectionId: null,
        type: PhotoAttachmentType.stockCardImport,
        createdAt: DateTime.now(),
        notes: 'Aus Stockkartenimport',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Kontrolle bearbeiten' : 'Kontrolle erfassen'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              _selectedHiveId == null
                  ? 'Neue Stockkontrolle'
                  : _isEditing
                  ? 'Stockkontrolle bearbeiten'
                  : 'Kontrolle erfassen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            if (_photos.isNotEmpty) ...[
              _InspectionPhotoReference(
                photos: _photos,
                sourcePhotoImport: _sourcePhotoImport,
                onRemove: _removePhoto,
              ),
              const SizedBox(height: 16),
            ],
            _SectionCard(
              title: 'Allgemein',
              children: [
                FutureBuilder<List<Hive>>(
                  future: _hivesFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const LinearProgressIndicator();
                    }

                    return DropdownButtonFormField<String>(
                      key: ValueKey(
                        'inspection-hive-${_selectedHiveId ?? 'none'}',
                      ),
                      initialValue: _selectedHiveId,
                      decoration: const InputDecoration(
                        labelText: 'Volk',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        for (final hive in snapshot.data!)
                          DropdownMenuItem(
                            value: hive.id,
                            child: Text(hive.number),
                          ),
                      ],
                      validator: (value) =>
                          value == null ? 'Bitte ein Volk auswählen.' : null,
                      onChanged: (value) =>
                          setState(() => _selectedHiveId = value),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _PickerTile(
                  icon: Icons.calendar_month,
                  label: 'Datum',
                  value: formatDate(_selectedDate),
                  onTap: _pickDate,
                ),
                _PickerTile(
                  icon: Icons.schedule,
                  label: 'Uhrzeit',
                  value: _selectedTime.format(context),
                  onTap: _pickTime,
                ),
                const SizedBox(height: 12),
                _DropdownField(
                  label: 'Gemütszustand',
                  value: _mood,
                  values: const ['ruhig', 'nervoes', 'aggressiv', 'traege'],
                  onChanged: (value) => setState(() => _mood = value),
                ),
              ],
            ),
            _SectionCard(
              title: 'Königin und Brut',
              children: [
                _SwitchField(
                  title: 'Königin gesehen',
                  value: _queenSeen,
                  onChanged: (value) => setState(() => _queenSeen = value),
                ),
                _DropdownField(
                  label: 'Wabensitz',
                  value: _combPosition,
                  values: const ['links', 'mittig', 'rechts', 'breit verteilt'],
                  onChanged: (value) => setState(() => _combPosition = value),
                ),
                _SwitchField(
                  title: 'Weiselzellen gesehen',
                  value: _queenCellsSeen,
                  onChanged: (value) => setState(() => _queenCellsSeen = value),
                ),
                _SwitchField(
                  title: 'Schwarmzellen gesehen',
                  value: _swarmCellsSeen,
                  onChanged: (value) => setState(() => _swarmCellsSeen = value),
                ),
                _SwitchField(
                  title: 'Nachschaffungszellen gesehen',
                  value: _emergencyCellsSeen,
                  onChanged: (value) =>
                      setState(() => _emergencyCellsSeen = value),
                ),
                _SwitchField(
                  title: 'Zellen entfernt',
                  value: _cellsRemoved,
                  onChanged: (value) => setState(() => _cellsRemoved = value),
                ),
                _NumberField(
                  controller: _broodFramesController,
                  label: 'Anzahl Brutrahmen',
                  validator: _validateNonNegativeInt,
                ),
                _DropdownField(
                  label: 'Königinnenfarbe',
                  value: _queenColor,
                  values: const ['Weiss', 'Gelb', 'Rot', 'Gruen', 'Blau'],
                  onChanged: (value) => setState(() => _queenColor = value),
                ),
              ],
            ),
            _SectionCard(
              title: 'Drohnenrahmen',
              children: [
                _DropdownField(
                  label: 'Drohnenrahmen-Füllgrad',
                  value: _droneFrameFillLevel,
                  values: const ['leer', 'angelegt', 'halb gefuellt', 'voll'],
                  onChanged: (value) =>
                      setState(() => _droneFrameFillLevel = value),
                ),
                _SwitchField(
                  title: 'Drohnenrahmen entfernt',
                  value: _droneFrameRemoved,
                  onChanged: (value) =>
                      setState(() => _droneFrameRemoved = value),
                ),
                _SwitchField(
                  title: 'Drohnenrahmen erneuert',
                  value: _droneFrameRenewed,
                  onChanged: (value) =>
                      setState(() => _droneFrameRenewed = value),
                ),
              ],
            ),
            _SectionCard(
              title: 'Volksstaerke und Futter',
              children: [
                Text('Volksstaerke: $_colonyStrength'),
                Slider(
                  value: _colonyStrength.toDouble(),
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _colonyStrength.toString(),
                  onChanged: (value) =>
                      setState(() => _colonyStrength = value.round()),
                ),
                _DropdownField(
                  label: 'Futterstatus',
                  value: _feedStatus,
                  values: const ['knapp', 'ausreichend', 'gut', 'sehr gut'],
                  onChanged: (value) => setState(() => _feedStatus = value),
                ),
                _SwitchField(
                  title: 'Fütterung durchgeführt',
                  value: _feedingDone,
                  onChanged: (value) => setState(() => _feedingDone = value),
                ),
                _DropdownField(
                  label: 'Futterart',
                  value: _feedType,
                  values: const [
                    'kein Futter',
                    'Zuckerwasser',
                    'Futterteig',
                    'Sirup',
                  ],
                  onChanged: (value) => setState(() => _feedType = value),
                ),
                _NumberField(
                  controller: _feedAmountController,
                  label: 'Futtermenge in Liter oder kg',
                  validator: _validateOptionalNonNegativeDouble,
                ),
              ],
            ),
            _SectionCard(
              title: 'Honigraum',
              children: [
                _SwitchField(
                  title: 'Absperrgitter eingelegt',
                  value: _queenExcluderInserted,
                  onChanged: (value) =>
                      setState(() => _queenExcluderInserted = value),
                ),
                _NumberField(
                  controller: _honeySupersController,
                  label: 'Anzahl Honigräume',
                  validator: _validateNonNegativeInt,
                ),
                _DropdownField(
                  label: 'Füllstand Honigräume',
                  value: _honeySuperFillLevel,
                  values: const [
                    'leer',
                    'gering',
                    'halb voll',
                    'fast voll',
                    'voll',
                  ],
                  onChanged: (value) =>
                      setState(() => _honeySuperFillLevel = value),
                ),
                _DropdownField(
                  label: 'Verdeckelungszustand Honig',
                  value: _honeyCappingState,
                  values: const [
                    'unverdeckt',
                    'teilweise verdeckelt',
                    'mehrheitlich verdeckelt',
                    'voll verdeckelt',
                  ],
                  onChanged: (value) =>
                      setState(() => _honeyCappingState = value),
                ),
                _NumberField(
                  controller: _honeyWaterController,
                  label: 'Wassergehalt Honig in Prozent',
                  validator: _validateOptionalPercent,
                ),
                _SwitchField(
                  title: 'Bienenflucht eingelegt',
                  value: _beeEscapeInserted,
                  onChanged: (value) =>
                      setState(() => _beeEscapeInserted = value),
                ),
              ],
            ),
            _SectionCard(
              title: 'Behandlung',
              children: [
                _SwitchField(
                  title: 'Varroabehandlung durchgefuehrt',
                  value: _varroaTreatmentDone,
                  onChanged: (value) =>
                      setState(() => _varroaTreatmentDone = value),
                ),
                _DropdownField(
                  label: 'Varroabehandlungsmittel',
                  value: _varroaTreatment,
                  values: const [
                    'keine',
                    'Ameisensaeure',
                    'Oxalsaeure',
                    'Milchsaeure',
                    'Thymol',
                  ],
                  onChanged: (value) =>
                      setState(() => _varroaTreatment = value),
                ),
              ],
            ),
            _SectionCard(
              title: 'Notizen',
              children: [
                TextFormField(
                  controller: _notesController,
                  minLines: 4,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    labelText: 'Notizen',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
            _SectionCard(
              title: 'Fotos zur Kontrolle',
              children: [
                Text(
                  _photos.isEmpty
                      ? 'Keine Fotos zugeordnet.'
                      : '${_photos.length} Foto(s) zugeordnet.',
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _pickPhotos,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Foto zur Kontrolle hinzufuegen'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _saveInspection,
              icon: const Icon(Icons.save),
              label: Text(
                _isEditing ? 'Änderungen speichern' : 'Kontrolle speichern',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      if (!mounted) {
        return;
      }
      setState(() => _selectedDate = pickedDate);
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      if (!mounted) {
        return;
      }
      setState(() => _selectedTime = pickedTime);
    }
  }

  Future<void> _saveInspection() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final date = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final existingInspection = _existingInspection;
    final inspection = Inspection(
      id:
          existingInspection?.id ??
          'inspection-${DateTime.now().microsecondsSinceEpoch}',
      hiveId: _selectedHiveId!,
      date: date,
      mood: _mood,
      queenSeen: _queenSeen,
      combPosition: _combPosition,
      queenCellsSeen: _queenCellsSeen,
      swarmCellsSeen: _swarmCellsSeen,
      emergencyCellsSeen: _emergencyCellsSeen,
      cellsRemoved: _cellsRemoved,
      droneFrameFillLevel: _droneFrameFillLevel,
      droneFrameRemoved: _droneFrameRemoved,
      droneFrameRenewed: _droneFrameRenewed,
      colonyStrength: _colonyStrength,
      broodFrameCount: int.parse(_broodFramesController.text),
      feedStatus: _feedStatus,
      queenColor: _queenColor,
      queenExcluderInserted: _queenExcluderInserted,
      honeySuperCount: int.parse(_honeySupersController.text),
      honeySuperFillLevel: _honeySuperFillLevel,
      honeyCappingState: _honeyCappingState,
      honeyWaterContent: _parseOptionalDouble(_honeyWaterController.text),
      beeEscapeInserted: _beeEscapeInserted,
      varroaTreatmentDone: _varroaTreatmentDone,
      varroaTreatment: _varroaTreatment,
      feedingDone: _feedingDone,
      feedType: _feedType,
      feedAmount: _parseOptionalDouble(_feedAmountController.text),
      notes: _notesController.text.trim(),
    );

    if (_isEditing) {
      await AppRepositories.instance.inspections.updateInspection(inspection);
    } else {
      await AppRepositories.instance.inspections.createInspection(inspection);
    }

    await AppRepositories.instance.photos.upsertAll(
      _photos.map(
        (photo) => photo.copyWith(
          clearLinkedHiveId: true,
          linkedInspectionId: inspection.id,
          type: PhotoAttachmentType.inspectionPhoto,
        ),
      ),
    );
    for (final photoId in _removedPhotoIds) {
      await AppRepositories.instance.photos.delete(photoId);
    }
    final sourceImportId = widget.arguments?.sourcePhotoImportId;
    if (sourceImportId != null) {
      StockCardImportService.instance.markDraftCreated(sourceImportId);
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Kontrolle wurde aktualisiert.'
              : 'Kontrolle wurde gespeichert.',
        ),
      ),
    );
    Navigator.pop(context, true);
  }

  Future<void> _pickPhotos() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: false,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final now = DateTime.now();
    var index = 0;
    final additions = result.files.map((file) {
      return PhotoAttachment(
        id: 'photo-${now.microsecondsSinceEpoch}-${index++}',
        localPath: file.path ?? file.name,
        filename: file.name,
        linkedHiveId: _selectedHiveId,
        linkedInspectionId: _existingInspection?.id,
        type: PhotoAttachmentType.inspectionPhoto,
        createdAt: now,
        notes: '',
      );
    }).toList();

    if (!mounted) {
      return;
    }
    setState(() => _photos.addAll(additions));
  }

  void _removePhoto(PhotoAttachment photo) {
    setState(() {
      _photos.removeWhere((item) => item.id == photo.id);
      if (photo.linkedInspectionId != null || photo.linkedHiveId != null) {
        _removedPhotoIds.add(photo.id);
      }
    });
  }

  String? _validateNonNegativeInt(String? value) {
    final number = int.tryParse(value ?? '');
    if (number == null) {
      return 'Bitte eine ganze Zahl eingeben.';
    }
    if (number < 0) {
      return 'Der Wert darf nicht negativ sein.';
    }
    return null;
  }

  String? _validateOptionalNonNegativeDouble(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final number = double.tryParse(value.replaceAll(',', '.'));
    if (number == null) {
      return 'Bitte eine Zahl eingeben.';
    }
    if (number < 0) {
      return 'Der Wert darf nicht negativ sein.';
    }
    return null;
  }

  String? _validateOptionalPercent(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final number = double.tryParse(value.replaceAll(',', '.'));
    if (number == null) {
      return 'Bitte eine Zahl eingeben.';
    }
    if (number < 0 || number > 100) {
      return 'Bitte einen Prozentwert zwischen 0 und 100 eingeben.';
    }
    return null;
  }

  double? _parseOptionalDouble(String value) {
    if (value.trim().isEmpty) {
      return null;
    }

    return double.parse(value.replaceAll(',', '.'));
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

class _InspectionPhotoReference extends StatelessWidget {
  const _InspectionPhotoReference({
    required this.photos,
    required this.sourcePhotoImport,
    required this.onRemove,
  });

  final List<PhotoAttachment> photos;
  final StockCardPhotoImport? sourcePhotoImport;
  final ValueChanged<PhotoAttachment> onRemove;

  @override
  Widget build(BuildContext context) {
    final primaryPhoto = photos.first;
    final sourceBytes = sourcePhotoImport?.bytes;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sourceBytes != null)
            Image.memory(
              sourceBytes,
              width: double.infinity,
              height: 280,
              fit: BoxFit.contain,
            )
          else
            PhotoPreview(
              localPath: primaryPhoto.localPath,
              filename: primaryPhoto.filename,
              width: double.infinity,
              height: 180,
              fit: BoxFit.contain,
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Foto als Ausfuellhilfe',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(primaryPhoto.localPath),
                if (photos.length > 1) ...[
                  const SizedBox(height: 12),
                  Text('${photos.length - 1} weitere Foto(s)'),
                ],
                const SizedBox(height: 12),
                for (final photo in photos)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: PhotoPreview(
                      localPath: photo.localPath,
                      filename: photo.filename,
                      width: 56,
                      height: 56,
                    ),
                    title: Text(photo.filename),
                    subtitle: Text(photo.localPath),
                    trailing: IconButton(
                      onPressed: () => onRemove(photo),
                      icon: const Icon(Icons.close),
                      tooltip: 'Foto entfernen',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
      trailing: const Icon(Icons.edit),
      onTap: onTap,
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> values;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        key: ValueKey('$label-$value'),
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: [
          for (final item in values)
            DropdownMenuItem(value: item, child: Text(_displayValue(item))),
        ],
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }

  String _displayValue(String value) {
    return switch (value) {
      'Weiss' => 'Weiß',
      'Gruen' => 'Grün',
      _ => value,
    };
  }
}

class _SwitchField extends StatelessWidget {
  const _SwitchField({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.controller,
    required this.label,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
