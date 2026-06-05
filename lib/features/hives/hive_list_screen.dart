import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/beekeeper_task.dart';
import '../../core/models/hive.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';

class HiveListScreen extends StatefulWidget {
  const HiveListScreen({super.key});

  @override
  State<HiveListScreen> createState() => _HiveListScreenState();
}

class _HiveListScreenState extends State<HiveListScreen>
    with AppDataListener<HiveListScreen> {
  final _searchController = TextEditingController();
  late Future<_HiveListData> _future;
  String _searchQuery = '';
  HiveStatus? _statusFilter;
  String? _beeStandFilterId;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    if (!mounted) {
      return;
    }
    debugPrint('HiveListScreen: reload requested');
    final future = _loadData();
    setState(() {
      _future = future;
    });
    await future;
  }

  @override
  void onAppDataChanged() {
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Völker')),
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
          final filteredHives = _filterHives(data);
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filteredHives.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _HiveFilters(
                  searchController: _searchController,
                  searchQuery: _searchQuery,
                  statusFilter: _statusFilter,
                  beeStandFilterId: _beeStandFilterId,
                  beeStands: data.beeStands,
                  resultCount: filteredHives.length,
                  onSearchChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                  onStatusChanged: (value) {
                    setState(() => _statusFilter = value);
                  },
                  onBeeStandChanged: (value) {
                    setState(() => _beeStandFilterId = value);
                  },
                );
              }

              final hive = filteredHives[index - 1];
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
    debugPrint('HiveListScreen: opening create hive form');
    final changed = await Navigator.pushNamed(context, AppRoutes.hiveForm);
    debugPrint('HiveListScreen: returned from hive form changed=$changed');
    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<_HiveListData> _loadData() async {
    debugPrint('HiveListScreen: loading data');
    final repositories = AppRepositories.instance;
    final hives = await repositories.hives.getAll();
    final beeStands = await repositories.apiaries.getAll();
    final tasks = await repositories.tasks.getAllSorted();
    final openTasksByHive = <String, List<BeekeeperTask>>{};

    for (final task in tasks.where((task) => task.isOpen)) {
      openTasksByHive.putIfAbsent(task.hiveId, () => []).add(task);
    }

    debugPrint('HiveListScreen: loaded ${hives.length} hives');
    return _HiveListData(
      hives: hives,
      beeStands: beeStands,
      openTasksByHive: openTasksByHive,
    );
  }

  List<Hive> _filterHives(_HiveListData data) {
    final query = _searchQuery.trim().toLowerCase();

    return data.hives.where((hive) {
      final beeStand = data.beeStandById(hive.beeStandId);
      final matchesSearch =
          query.isEmpty ||
          hive.number.toLowerCase().contains(query) ||
          hive.name.toLowerCase().contains(query) ||
          beeStand.name.toLowerCase().contains(query) ||
          beeStand.location.toLowerCase().contains(query) ||
          hive.status.label.toLowerCase().contains(query) ||
          hive.status.name.toLowerCase().contains(query) ||
          hive.queenColor.toLowerCase().contains(query) ||
          hive.notes.toLowerCase().contains(query);
      final matchesStatus =
          _statusFilter == null || hive.status == _statusFilter;
      final matchesBeeStand =
          _beeStandFilterId == null || hive.beeStandId == _beeStandFilterId;

      return matchesSearch && matchesStatus && matchesBeeStand;
    }).toList();
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

class _HiveFilters extends StatelessWidget {
  const _HiveFilters({
    required this.searchController,
    required this.searchQuery,
    required this.statusFilter,
    required this.beeStandFilterId,
    required this.beeStands,
    required this.resultCount,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onBeeStandChanged,
  });

  final TextEditingController searchController;
  final String searchQuery;
  final HiveStatus? statusFilter;
  final String? beeStandFilterId;
  final List<BeeStand> beeStands;
  final int resultCount;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<HiveStatus?> onStatusChanged;
  final ValueChanged<String?> onBeeStandChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Suchen und filtern',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text('$resultCount Treffer'),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Volk, Stand oder Status suchen',
                border: const OutlineInputBorder(),
                suffixIcon: searchQuery.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          searchController.clear();
                          onSearchChanged('');
                        },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Suche leeren',
                      ),
              ),
              onChanged: onSearchChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('hive-status-${statusFilter?.name ?? 'all'}'),
              initialValue: statusFilter?.name ?? 'all',
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Alle')),
                for (final status in HiveStatus.values)
                  DropdownMenuItem(
                    value: status.name,
                    child: Text(status.label),
                  ),
              ],
              onChanged: (value) {
                onStatusChanged(
                  value == null || value == 'all'
                      ? null
                      : HiveStatus.values.firstWhere(
                          (status) => status.name == value,
                        ),
                );
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('hive-bee-stand-${beeStandFilterId ?? 'all'}'),
              initialValue: beeStandFilterId ?? 'all',
              decoration: const InputDecoration(
                labelText: 'Bienenstand',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Alle')),
                for (final beeStand in beeStands)
                  DropdownMenuItem(
                    value: beeStand.id,
                    child: Text('${beeStand.name} - ${beeStand.location}'),
                  ),
              ],
              onChanged: (value) {
                onBeeStandChanged(
                  value == null || value == 'all' ? null : value,
                );
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                FilterChip(
                  label: const Text('Alle'),
                  selected: statusFilter == null,
                  selectedColor: AppColors.goldText,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: statusFilter == null
                        ? Colors.white
                        : AppColors.anthracite,
                  ),
                  onSelected: (_) => onStatusChanged(null),
                ),
                for (final status in HiveStatus.values)
                  FilterChip(
                    label: Text(status.label),
                    selected: statusFilter == status,
                    selectedColor: AppColors.goldText,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: statusFilter == status
                          ? Colors.white
                          : AppColors.anthracite,
                    ),
                    onSelected: (_) => onStatusChanged(status),
                  ),
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
  final Future<void> Function() onChanged;

  @override
  Widget build(BuildContext context) {
    final warnings = _warningsForHive(hive, openTasks);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          await Navigator.pushNamed(
            context,
            AppRoutes.hiveDetail,
            arguments: hive.id,
          );
          await onChanged();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.goldText,
                    foregroundColor: Colors.white,
                    child: Text(_shortHiveNumber(hive.number)),
                  ),
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
                    label: 'Königin ${hive.queenYear}',
                  ),
                  _InfoChip(
                    icon: Icons.palette_outlined,
                    label: _queenColorLabel(hive.queenColor),
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
                        avatar: const Icon(
                          Icons.warning_amber,
                          size: 18,
                          color: Colors.white,
                        ),
                        label: Text(warning),
                        backgroundColor: AppColors.warningRed,
                        labelStyle: const TextStyle(color: Colors.white),
                        side: BorderSide.none,
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
      warnings.add('Kontrolle fällig');
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

  String _queenColorLabel(String value) {
    return switch (value) {
      'Weiss' => 'Weiß',
      'Gruen' => 'Grün',
      _ => value,
    };
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final HiveStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      HiveStatus.active => AppColors.sageGreen,
      HiveStatus.dissolved => const Color(0xFFE2E0D4),
      HiveStatus.united => AppColors.goldText,
      HiveStatus.sold => AppColors.darkGold,
      HiveStatus.lost => AppColors.warningRed,
    };
    final textColor = switch (status) {
      HiveStatus.dissolved => AppColors.anthracite,
      _ => Colors.white,
    };

    return Chip(
      label: Text(status.label),
      backgroundColor: color,
      labelStyle: TextStyle(color: textColor),
      visualDensity: VisualDensity.compact,
      side: BorderSide.none,
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
        Icon(icon, size: 18, color: AppColors.goldText),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
