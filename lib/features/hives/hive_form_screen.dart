import 'package:flutter/material.dart';

import '../../core/models/bee_stand.dart';
import '../../core/models/hive.dart';
import '../../core/services/app_repositories.dart';

class HiveFormArguments {
  const HiveFormArguments({this.hiveId, this.initialBeeStandId});

  final String? hiveId;
  final String? initialBeeStandId;
}

class HiveFormScreen extends StatefulWidget {
  const HiveFormScreen({super.key, required this.arguments});

  final HiveFormArguments? arguments;

  @override
  State<HiveFormScreen> createState() => _HiveFormScreenState();
}

class _HiveFormScreenState extends State<HiveFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _nameController = TextEditingController();
  final _hiveTypeController = TextEditingController(text: 'Zander Magazin');
  final _queenYearController = TextEditingController(
    text: DateTime.now().year.toString(),
  );
  final _queenOriginController = TextEditingController();
  final _notesController = TextEditingController();

  late Future<_HiveFormData> _future;
  Hive? _existingHive;
  String? _selectedBeeStandId;
  String _queenColor = 'Weiss';
  HiveStatus _status = HiveStatus.active;

  bool get _isEditing => _existingHive != null;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    _hiveTypeController.dispose();
    _queenYearController.dispose();
    _queenOriginController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<_HiveFormData> _loadData() async {
    final repositories = AppRepositories.instance;
    final beeStands = await repositories.apiaries.getAll();
    final hiveId = widget.arguments?.hiveId;

    if (hiveId != null) {
      final hive = await repositories.hives.getHiveById(hiveId);
      _existingHive = hive;
      _numberController.text = hive.number;
      _nameController.text = hive.name;
      _hiveTypeController.text = hive.hiveType;
      _queenYearController.text = hive.queenYear.toString();
      _queenOriginController.text = hive.queenOrigin;
      _notesController.text = hive.notes;
      _selectedBeeStandId = hive.beeStandId;
      _queenColor = hive.queenColor;
      _status = hive.status;
      if (mounted) {
        setState(() {});
      }
    } else if (widget.arguments?.initialBeeStandId != null) {
      _selectedBeeStandId = widget.arguments!.initialBeeStandId;
    } else if (beeStands.isNotEmpty) {
      _selectedBeeStandId = beeStands.first.id;
    }

    return _HiveFormData(beeStands: beeStands);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Volk bearbeiten' : 'Neues Volk'),
      ),
      body: FutureBuilder<_HiveFormData>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _numberController,
                          decoration: const InputDecoration(
                            labelText: 'Volk-Nummer',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Bitte eine Volk-Nummer eingeben.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name optional',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedBeeStandId,
                          decoration: const InputDecoration(
                            labelText: 'Bienenstand',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            for (final beeStand in data.beeStands)
                              DropdownMenuItem(
                                value: beeStand.id,
                                child: Text(beeStand.name),
                              ),
                          ],
                          validator: (value) => value == null
                              ? 'Bitte einen Bienenstand auswaehlen.'
                              : null,
                          onChanged: (value) {
                            setState(() => _selectedBeeStandId = value);
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _hiveTypeController,
                          decoration: const InputDecoration(
                            labelText: 'Beutentyp',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _queenYearController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Koeniginnenjahr',
                            border: OutlineInputBorder(),
                          ),
                          validator: _validateQueenYear,
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: _queenColor,
                          decoration: const InputDecoration(
                            labelText: 'Koeniginnenfarbe',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Weiss',
                              child: Text('Weiss'),
                            ),
                            DropdownMenuItem(
                              value: 'Gelb',
                              child: Text('Gelb'),
                            ),
                            DropdownMenuItem(value: 'Rot', child: Text('Rot')),
                            DropdownMenuItem(
                              value: 'Gruen',
                              child: Text('Gruen'),
                            ),
                            DropdownMenuItem(
                              value: 'Blau',
                              child: Text('Blau'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _queenColor = value);
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _queenOriginController,
                          decoration: const InputDecoration(
                            labelText: 'Koeniginnenherkunft optional',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<HiveStatus>(
                          initialValue: _status,
                          decoration: const InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            for (final status in HiveStatus.values)
                              DropdownMenuItem(
                                value: status,
                                child: Text(status.label),
                              ),
                          ],
                          validator: (value) => value == null
                              ? 'Bitte einen Status auswaehlen.'
                              : null,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _status = value);
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _notesController,
                          minLines: 3,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            labelText: 'Notizen',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _saveHive,
                  icon: const Icon(Icons.save),
                  label: Text(
                    _isEditing ? 'Aenderungen speichern' : 'Volk speichern',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? _validateQueenYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final year = int.tryParse(value);
    final currentYear = DateTime.now().year;
    if (year == null) {
      return 'Bitte ein gueltiges Jahr eingeben.';
    }
    if (year < 1900 || year > currentYear + 1) {
      return 'Bitte ein realistisches Jahr eingeben.';
    }
    return null;
  }

  Future<void> _saveHive() async {
    debugPrint('HiveFormScreen: saving hive');
    if (!_formKey.currentState!.validate()) {
      debugPrint('HiveFormScreen: validation failed');
      return;
    }

    final now = DateTime.now();
    final existingHive = _existingHive;
    final queenYear =
        int.tryParse(_queenYearController.text.trim()) ?? now.year;
    final hive = Hive(
      id: existingHive?.id ?? 'hive-${now.microsecondsSinceEpoch}',
      number: _numberController.text.trim(),
      beeStandId: _selectedBeeStandId!,
      name: _nameController.text.trim(),
      hiveType: _hiveTypeController.text.trim().isEmpty
          ? 'Magazin'
          : _hiveTypeController.text.trim(),
      queenYear: queenYear,
      queenColor: _queenColor,
      queenOrigin: _queenOriginController.text.trim(),
      status: _status,
      notes: _notesController.text.trim(),
      createdAt: existingHive?.createdAt ?? now,
      updatedAt: now,
      lastInspectionDate: existingHive?.lastInspectionDate,
    );

    if (_isEditing) {
      debugPrint(
        'HiveFormScreen: updateHive id=${hive.id} number=${hive.number}',
      );
      await AppRepositories.instance.hives.updateHive(hive);
    } else {
      debugPrint(
        'HiveFormScreen: createHive id=${hive.id} number=${hive.number}',
      );
      await AppRepositories.instance.hives.createHive(hive);
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing ? 'Volk wurde aktualisiert.' : 'Volk wurde angelegt.',
        ),
      ),
    );
    debugPrint('HiveFormScreen: popping with true for id=${hive.id}');
    Navigator.pop(context, true);
  }
}

class _HiveFormData {
  const _HiveFormData({required this.beeStands});

  final List<BeeStand> beeStands;
}
