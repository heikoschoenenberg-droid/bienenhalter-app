import 'package:flutter/material.dart';

import '../../core/models/bee_stand.dart';
import '../../core/services/app_repositories.dart';

class ApiaryFormArguments {
  const ApiaryFormArguments({this.apiaryId});

  final String? apiaryId;
}

class ApiaryFormScreen extends StatefulWidget {
  const ApiaryFormScreen({super.key, required this.arguments});

  final ApiaryFormArguments? arguments;

  @override
  State<ApiaryFormScreen> createState() => _ApiaryFormScreenState();
}

class _ApiaryFormScreenState extends State<ApiaryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  late Future<void> _future;
  BeeStand? _existingApiary;

  bool get _isEditing => _existingApiary != null;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final apiaryId = widget.arguments?.apiaryId;
    if (apiaryId == null) {
      return;
    }

    final apiary = await AppRepositories.instance.apiaries.getApiaryById(
      apiaryId,
    );
    _existingApiary = apiary;
    _nameController.text = apiary.name;
    _locationController.text = apiary.location;
    _notesController.text = apiary.notes;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Bienenstand bearbeiten' : 'Neuer Bienenstand',
        ),
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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Bitte einen Namen eingeben.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _locationController,
                          decoration: const InputDecoration(
                            labelText: 'Standort / Ort',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Bitte einen Standort eingeben.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _notesController,
                          minLines: 3,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            labelText: 'Notizen optional',
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
                  onPressed: _saveApiary,
                  icon: const Icon(Icons.save),
                  label: Text(
                    _isEditing
                        ? 'Änderungen speichern'
                        : 'Bienenstand speichern',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveApiary() async {
    debugPrint('ApiaryFormScreen: saving apiary');
    if (!_formKey.currentState!.validate()) {
      debugPrint('ApiaryFormScreen: validation failed');
      return;
    }

    final now = DateTime.now();
    final existingApiary = _existingApiary;
    final apiary = BeeStand(
      id: existingApiary?.id ?? 'stand-${now.microsecondsSinceEpoch}',
      name: _nameController.text.trim(),
      location: _locationController.text.trim(),
      notes: _notesController.text.trim(),
      createdAt: existingApiary?.createdAt ?? now,
      updatedAt: now,
    );

    if (_isEditing) {
      debugPrint(
        'ApiaryFormScreen: updateApiary id=${apiary.id} name=${apiary.name}',
      );
      await AppRepositories.instance.apiaries.updateApiary(apiary);
    } else {
      debugPrint(
        'ApiaryFormScreen: createApiary id=${apiary.id} name=${apiary.name}',
      );
      await AppRepositories.instance.apiaries.createApiary(apiary);
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Bienenstand wurde aktualisiert.'
              : 'Bienenstand wurde angelegt.',
        ),
      ),
    );
    debugPrint('ApiaryFormScreen: popping with true for id=${apiary.id}');
    Navigator.pop(context, true);
  }
}
