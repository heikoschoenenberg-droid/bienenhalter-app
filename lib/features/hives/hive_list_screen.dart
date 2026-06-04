import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/beekeeper_task.dart';
import '../../core/models/hive.dart';
import '../../core/services/app_repositories.dart';

class HiveListScreen extends StatefulWidget {
  const HiveListScreen({super.key});

  @override
  State<HiveListScreen> createState() => _HiveListScreenState();
}

class _HiveListScreenState extends State<HiveListScreen> {
  late Future<_HiveListData> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  void _reload() {
    setState(() => _future = _loadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voelker')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateHive,
        icon: const Icon(Icons.add),
        label: const Text('Neues Volk'),
      ),
      body: FutureBuilder<_HiveListData>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.hives.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const _HiveFilterPlaceholder();
              }

              final hive = data.hives[index - 1];
              return _HiveCard(
                hive: hive,
                beeStand: data.beeStandById(hive.beeStandId),
                openTasks: data.openTasksByHive[hive.id] ?? const [],
                onChanged: _reload,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openCreateHive() async {
    final changed = await Navigator.pushNamed(context, AppRoutes.hiveForm);
    if (changed == true && mounted) {
      _reload();
    }
  }

  Future<_HiveListData> _loadData() async {
    final repositories = AppRepositories.instance;
    final hives = await repositories.hives.getAll();
    final beeStands = await repositories.apiaries.getAll();
    final tasks = await repositories.tasks.getAllSorted();
    final openTasksByHive = <String, List<BeekeeperTask>>{};

    for (final task in tasks.where((task) => task.isOpen)) {
      openTasksByHive.putIfAbsent(task.hiveId, () => []).add(task);
    }

    return _HiveListData(
      hives: hives,
      beeStands: beeStands,
      openTasksByHive: openTasksByHive,
    );
  }
}

class _HiveListData {
  const _HiveListData({
    required this.hives,
    required this.beeStands,
    required this.openTasksByHive,
  });

  final List<Hive> hives;
  final List<BeeStand> beeStands;
  final Map<String, List<BeekeeperTask>> openTasksByHive;

  BeeStand beeStandById(String id) {
    return beeStands.firstWhere((beeStand) => beeStand.id == id);
  }
}

class _HiveFilterPlaceholder extends StatelessWidget {
  const _HiveFilterPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suchen und filtern',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Volk, Stand oder Status suchen',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(height: 12),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Alle')),
                Chip(label: Text('Aktiv')),
                Chip(label: Text('Beobachten')),
                Chip(label: Text('Aufgaben offen')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HiveCard extends StatelessWidget {
  const _HiveCard({
    required this.hive,
    required this.beeStand,
    required this.openTasks,
    required this.onChanged,
  });

  final Hive hive;
  final BeeStand beeStand;
  final List<BeekeeperTask> openTasks;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final warnings = _warningsForHive(hive, openTasks);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.hiveDetail,
          arguments: hive.id,
        ).then((_) => onChanged()),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Text(_shortHiveNumber(hive.number))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hive.number,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text('${beeStand.name} - ${beeStand.location}'),
                      ],
                    ),
                  ),
                  _StatusPill(status: hive.status),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.calendar_month,
                    label: 'Koenigin ${hive.queenYear}',
                  ),
                  _InfoChip(
                    icon: Icons.palette_outlined,
                    label: hive.queenColor,
                  ),
                  _InfoChip(
                    icon: Icons.fact_check_outlined,
                    label: formatDate(hive.lastInspectionDate),
                  ),
                ],
              ),
              if (warnings.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final warning in warnings)
                      Chip(
                        avatar: const Icon(Icons.warning_amber, size: 18),
                        label: Text(warning),
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.errorContainer,
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<String> _warningsForHive(Hive hive, List<BeekeeperTask> tasks) {
    final warnings = <String>{};
    final today = DateTime.now();
    final latest = hive.lastInspectionDate;

    if (latest == null || today.difference(latest).inDays >= 7) {
      warnings.add('Kontrolle faellig');
    }
    for (final task in tasks) {
      if (!task.dueDate.isAfter(today.add(const Duration(days: 7)))) {
        warnings.add(task.warningLabel);
      }
    }
    return warnings.toList();
  }

  String _shortHiveNumber(String number) {
    return number.replaceAll('Volk ', '').replaceAll('Ableger ', 'A');
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final HiveStatus status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = switch (status) {
      HiveStatus.active => colorScheme.primaryContainer,
      HiveStatus.dissolved => colorScheme.surfaceContainerHighest,
      HiveStatus.united => colorScheme.secondaryContainer,
      HiveStatus.sold => colorScheme.tertiaryContainer,
      HiveStatus.lost => colorScheme.errorContainer,
    };

    return Chip(
      label: Text(status.label),
      backgroundColor: color,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
