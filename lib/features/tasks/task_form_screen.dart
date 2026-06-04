import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/models/beekeeper_task.dart';
import '../../core/models/hive.dart';
import '../../core/services/app_repositories.dart';

class TaskFormArguments {
  const TaskFormArguments({this.taskId, this.initialHiveId});

  final String? taskId;
  final String? initialHiveId;
}

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key, required this.arguments});

  final TaskFormArguments? arguments;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  late Future<List<Hive>> _hivesFuture;
  BeekeeperTask? _existingTask;
  String? _selectedHiveId;
  BeekeeperTaskCategory _category = BeekeeperTaskCategory.inspection;
  BeekeeperTaskPriority _priority = BeekeeperTaskPriority.normal;
  DateTime _dueDate = DateTime.now();
  TimeOfDay? _dueTime;

  bool get _isEditing => _existingTask != null;

  @override
  void initState() {
    super.initState();
    _hivesFuture = AppRepositories.instance.hives.getAll();
    _selectedHiveId = widget.arguments?.initialHiveId;
    _loadExistingTask();
  }

  Future<void> _loadExistingTask() async {
    final taskId = widget.arguments?.taskId;
    if (taskId != null) {
      _existingTask = await AppRepositories.instance.tasks.getById(taskId);
      final task = _existingTask!;
      _titleController.text = task.title;
      _descriptionController.text = task.description;
      _selectedHiveId = task.hiveId;
      _category = task.category;
      _priority = task.priority;
      _dueDate = task.dueDate;
      _dueTime = task.dueTime == null
          ? null
          : TimeOfDay(hour: task.dueTime!.hour, minute: task.dueTime!.minute);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Aufgabe bearbeiten' : 'Neue Aufgabe'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Titel',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Bitte einen Titel eingeben.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: 'Beschreibung',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 12),
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
                          validator: (value) => value == null
                              ? 'Bitte ein Volk auswaehlen.'
                              : null,
                          onChanged: (value) {
                            setState(() => _selectedHiveId = value);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<BeekeeperTaskCategory>(
                      initialValue: _category,
                      decoration: const InputDecoration(
                        labelText: 'Kategorie',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        for (final category in BeekeeperTaskCategory.values)
                          DropdownMenuItem(
                            value: category,
                            child: Text(category.label),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _category = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<BeekeeperTaskPriority>(
                      initialValue: _priority,
                      decoration: const InputDecoration(
                        labelText: 'Prioritaet',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        for (final priority in BeekeeperTaskPriority.values)
                          DropdownMenuItem(
                            value: priority,
                            child: Text(priority.label),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _priority = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _PickerTile(
                      icon: Icons.calendar_month,
                      label: 'Faelligkeitsdatum',
                      value: formatDate(_dueDate),
                      onTap: _pickDueDate,
                    ),
                    _PickerTile(
                      icon: Icons.schedule,
                      label: 'Faelligkeitszeit',
                      value: _dueTime == null
                          ? 'Keine Uhrzeit'
                          : _dueTime!.format(context),
                      onTap: _pickDueTime,
                    ),
                    if (_dueTime != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () => setState(() => _dueTime = null),
                          icon: const Icon(Icons.close),
                          label: const Text('Uhrzeit entfernen'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _saveTask,
              icon: const Icon(Icons.save),
              label: Text(
                _isEditing ? 'Aenderungen speichern' : 'Aufgabe speichern',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    setState(() => _dueDate = pickedDate);
  }

  Future<void> _pickDueTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _dueTime ?? TimeOfDay.now(),
    );

    if (pickedTime == null || !mounted) {
      return;
    }

    setState(() => _dueTime = pickedTime);
  }

  Future<void> _saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final dueTime = _dueTime == null
        ? null
        : DateTime(
            _dueDate.year,
            _dueDate.month,
            _dueDate.day,
            _dueTime!.hour,
            _dueTime!.minute,
          );

    final task = BeekeeperTask(
      id: _existingTask?.id ?? 'task-${DateTime.now().microsecondsSinceEpoch}',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      hiveId: _selectedHiveId!,
      category: _category,
      dueDate: DateTime(_dueDate.year, _dueDate.month, _dueDate.day),
      dueTime: dueTime,
      status: _existingTask?.status ?? BeekeeperTaskStatus.open,
      priority: _priority,
      createdAt: _existingTask?.createdAt ?? DateTime.now(),
      completedAt: _existingTask?.completedAt,
    );

    await AppRepositories.instance.tasks.upsert(task);
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditing
              ? 'Aufgabe wurde aktualisiert.'
              : 'Aufgabe wurde angelegt.',
        ),
      ),
    );
    Navigator.pop(context, true);
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

extension on BeekeeperTaskCategory {
  String get label {
    return switch (this) {
      BeekeeperTaskCategory.inspection => 'Kontrolle',
      BeekeeperTaskCategory.honeySuper => 'Honigraum',
      BeekeeperTaskCategory.beeEscape => 'Bienenflucht',
      BeekeeperTaskCategory.varroa => 'Varroa',
      BeekeeperTaskCategory.feeding => 'Fuetterung',
      BeekeeperTaskCategory.queen => 'Koenigin',
      BeekeeperTaskCategory.other => 'Sonstiges',
    };
  }
}

extension on BeekeeperTaskPriority {
  String get label {
    return switch (this) {
      BeekeeperTaskPriority.low => 'Niedrig',
      BeekeeperTaskPriority.normal => 'Normal',
      BeekeeperTaskPriority.high => 'Hoch',
    };
  }
}
