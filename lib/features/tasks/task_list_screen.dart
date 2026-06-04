import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/demo/demo_data.dart';
import '../../core/models/beekeeper_task.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final groupedTasks = _groupTasks(DemoData.sortedTasks());

    return Scaffold(
      appBar: AppBar(title: const Text('Aufgaben')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openTaskForm(),
        icon: const Icon(Icons.add),
        label: const Text('Neue Aufgabe'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Aufgabenliste',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Offene Aufgaben stehen oben und sind nach Faelligkeit sortiert.',
          ),
          const SizedBox(height: 20),
          for (final group in groupedTasks.entries) ...[
            _TaskGroupTitle(title: group.key),
            const SizedBox(height: 8),
            for (final task in group.value) ...[
              _TaskCard(
                task: task,
                onOpen: () => _openTaskForm(taskId: task.id),
                onComplete: task.isOpen ? () => _completeTask(task.id) : null,
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 72),
        ],
      ),
    );
  }

  Future<void> _openTaskForm({String? taskId}) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.taskForm,
      arguments: TaskFormArguments(taskId: taskId),
    );

    if (changed == true && mounted) {
      setState(() {});
    }
  }

  void _completeTask(String taskId) {
    DemoData.completeTask(taskId);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aufgabe wurde als erledigt markiert.')),
    );
  }

  Map<String, List<BeekeeperTask>> _groupTasks(List<BeekeeperTask> tasks) {
    final groups = <String, List<BeekeeperTask>>{};

    for (final task in tasks) {
      final groupName = _groupName(task);
      groups.putIfAbsent(groupName, () => []).add(task);
    }

    return groups;
  }

  String _groupName(BeekeeperTask task) {
    if (!task.isOpen) {
      return 'Erledigt';
    }

    final today = DemoData.today;
    final dueDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    final currentDay = DateTime(today.year, today.month, today.day);
    final daysUntilDue = dueDate.difference(currentDay).inDays;

    if (daysUntilDue < 0) {
      return 'Ueberfaellig';
    }
    if (daysUntilDue == 0) {
      return 'Heute';
    }
    if (daysUntilDue <= 7) {
      return 'Naechste 7 Tage';
    }
    return 'Spaeter';
  }
}

class _TaskGroupTitle extends StatelessWidget {
  const _TaskGroupTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.onOpen,
    required this.onComplete,
  });

  final BeekeeperTask task;
  final VoidCallback onOpen;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final hive = DemoData.hiveById(task.hiveId);
    final isOverdue = _isOverdue(task);
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = task.isOpen
        ? Theme.of(context).textTheme.bodyMedium
        : Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colorScheme.outline);

    return Card(
      color: isOverdue ? colorScheme.errorContainer : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: !task.isOpen,
                onChanged: onComplete == null ? null : (_) => onComplete!(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: task.isOpen ? null : colorScheme.outline,
                      ),
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(task.description, style: textStyle),
                    ],
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text(hive.number)),
                        Chip(label: Text(task.categoryLabel)),
                        Chip(label: Text(task.priorityLabel)),
                        Chip(
                          label: Text(
                            formatDueDate(task.dueDate, task.dueTime),
                          ),
                        ),
                        if (isOverdue)
                          const Chip(
                            avatar: Icon(Icons.warning_amber, size: 18),
                            label: Text('Ueberfaellig'),
                          ),
                        if (!task.isOpen && task.completedAt != null)
                          Chip(
                            label: Text(
                              'Erledigt: ${formatDate(task.completedAt)}',
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onOpen,
                icon: const Icon(Icons.edit),
                tooltip: 'Bearbeiten',
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isOverdue(BeekeeperTask task) {
    if (!task.isOpen) {
      return false;
    }

    final today = DemoData.today;
    final dueDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    final currentDay = DateTime(today.year, today.month, today.day);
    return dueDate.isBefore(currentDay);
  }
}
