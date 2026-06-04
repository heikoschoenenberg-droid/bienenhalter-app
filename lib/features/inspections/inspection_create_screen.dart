import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/services/app_repositories.dart';

class InspectionCreateScreen extends StatefulWidget {
  const InspectionCreateScreen({super.key, required this.hiveId});

  final String? hiveId;

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

  @override
  void initState() {
    super.initState();
    _selectedHiveId = widget.hiveId;
    _hivesFuture = AppRepositories.instance.hives.getAll();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontrolle erfassen')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              _selectedHiveId == null
                  ? 'Neue Stockkontrolle'
                  : 'Kontrolle erfassen',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
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
                          value == null ? 'Bitte ein Volk auswaehlen.' : null,
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
                  label: 'Gemuetszustand',
                  value: _mood,
                  values: const ['ruhig', 'nervoes', 'aggressiv', 'traege'],
                  onChanged: (value) => setState(() => _mood = value),
                ),
              ],
            ),
            _SectionCard(
              title: 'Koenigin und Brut',
              children: [
                _SwitchField(
                  title: 'Koenigin gesehen',
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
                  label: 'Koeniginnenfarbe',
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
                  label: 'Drohnenrahmen-Fuellgrad',
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
                  title: 'Fuetterung durchgefuehrt',
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
                  label: 'Anzahl Honigraeume',
                  validator: _validateNonNegativeInt,
                ),
                _DropdownField(
                  label: 'Fuellstand Honigraeume',
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
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _saveInspection,
              icon: const Icon(Icons.save),
              label: const Text('Kontrolle speichern'),
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

    final inspection = Inspection(
      id: 'inspection-${DateTime.now().microsecondsSinceEpoch}',
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

    await AppRepositories.instance.inspections.add(inspection);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kontrolle wurde gespeichert.')),
    );
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.hiveDetail,
      arguments: inspection.hiveId,
    );
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
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: [
          for (final item in values)
            DropdownMenuItem(value: item, child: Text(item)),
        ],
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
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
