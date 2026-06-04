import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/demo/demo_data.dart';
import '../../core/models/beekeeper_task.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupedTasks = _groupTasks(DemoData.sortedTasks());

    return Scaffold(
      appBar: AppBar(title: const Text('Aufgaben')),
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
              _TaskCard(task: task),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 8),
          ],
        ],
      ),
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
  const _TaskCard({required this.task});

  final BeekeeperTask task;

  @override
  Widget build(BuildContext context) {
    final hive = DemoData.hiveById(task.hiveId);
    final isOpen = task.status == BeekeeperTaskStatus.open;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isOpen ? Icons.radio_button_unchecked : Icons.check_circle,
              color: isOpen
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text(hive.number)),
                      Chip(label: Text(task.categoryLabel)),
                      Chip(label: Text(formatDate(task.dueDate))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(isOpen ? 'Offen' : 'Erledigt'),
          ],
        ),
      ),
    );
  }
}
