import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/hive.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';
import '../hives/hive_form_screen.dart';
import 'apiary_form_screen.dart';

class ApiaryDetailScreen extends StatefulWidget {
  const ApiaryDetailScreen({super.key, required this.apiaryId});

  final String? apiaryId;

  @override
  State<ApiaryDetailScreen> createState() => _ApiaryDetailScreenState();
}

class _ApiaryDetailScreenState extends State<ApiaryDetailScreen>
    with AppDataListener<ApiaryDetailScreen> {
  late Future<_ApiaryDetailData> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  Future<void> _reload() async {
    if (!mounted) {
      return;
    }
    debugPrint('ApiaryDetailScreen: reload requested');
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

  Future<_ApiaryDetailData> _loadData() async {
    final apiaryId = widget.apiaryId;
    if (apiaryId == null) {
      throw StateError('Missing apiary id');
    }

    final repositories = AppRepositories.instance;
    final apiary = await repositories.apiaries.getApiaryById(apiaryId);
    final allHives = await repositories.hives.listHives();
    final hives = allHives
        .where((hive) => hive.beeStandId == apiary.id)
        .toList();

    return _ApiaryDetailData(apiary: apiary, hives: hives);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.apiaryId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Bienenstand')),
        body: const Center(child: Text('Kein Bienenstand ausgewaehlt.')),
      );
    }

    return FutureBuilder<_ApiaryDetailData>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Bienenstand')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(data.apiary.name)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                data.apiary.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(data.apiary.location),
              const SizedBox(height: 20),
              _ActionGrid(
                onEdit: () => _openEditApiary(data.apiary.id),
                onCreateHive: () => _openCreateHive(data.apiary.id),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      _DetailRow(
                        label: 'Standort',
                        value: data.apiary.location,
                      ),
                      _DetailRow(
                        label: 'Voelker',
                        value: data.hives.length.toString(),
                      ),
                      if (data.apiary.notes.isNotEmpty)
                        _DetailRow(label: 'Notizen', value: data.apiary.notes),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Zugeordnete Voelker',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      if (data.hives.isEmpty)
                        const Text('Noch keine Voelker an diesem Stand.')
                      else
                        for (final hive in data.hives)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(hive.number),
                            subtitle: Text(hive.statusLabel),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                AppRoutes.hiveDetail,
                                arguments: hive.id,
                              );
                              await _reload();
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openEditApiary(String apiaryId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.apiaryForm,
      arguments: ApiaryFormArguments(apiaryId: apiaryId),
    );
    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _openCreateHive(String apiaryId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.hiveForm,
      arguments: HiveFormArguments(initialBeeStandId: apiaryId),
    );
    if (changed == true && mounted) {
      await _reload();
    }
  }
}

class _ApiaryDetailData {
  const _ApiaryDetailData({required this.apiary, required this.hives});

  final BeeStand apiary;
  final List<Hive> hives;
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.onEdit, required this.onCreateHive});

  final VoidCallback onEdit;
  final VoidCallback onCreateHive;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final actions = [
          FilledButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit),
            label: const Text('Bearbeiten'),
          ),
          OutlinedButton.icon(
            onPressed: onCreateHive,
            icon: const Icon(Icons.add),
            label: const Text('Neues Volk an diesem Stand'),
          ),
        ];

        if (constraints.maxWidth < 560) {
          return Column(
            children: [
              for (final action in actions) ...[
                action,
                if (action != actions.last) const SizedBox(height: 10),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (final action in actions) ...[
              Expanded(child: action),
              if (action != actions.last) const SizedBox(width: 10),
            ],
          ],
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
