import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/hive.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';

class ApiaryListScreen extends StatefulWidget {
  const ApiaryListScreen({super.key});

  @override
  State<ApiaryListScreen> createState() => _ApiaryListScreenState();
}

class _ApiaryListScreenState extends State<ApiaryListScreen>
    with AppDataListener<ApiaryListScreen> {
  final _searchController = TextEditingController();
  late Future<_ApiaryListData> _future;
  String _searchQuery = '';

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
    debugPrint('ApiaryListScreen: reload requested');
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

  Future<_ApiaryListData> _loadData() async {
    debugPrint('ApiaryListScreen: loading data');
    final repositories = AppRepositories.instance;
    final apiaries = await repositories.apiaries.listApiaries();
    final hives = await repositories.hives.listHives();

    debugPrint('ApiaryListScreen: loaded ${apiaries.length} apiaries');
    return _ApiaryListData(apiaries: apiaries, hives: hives);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienenstaende')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateApiary,
        icon: const Icon(Icons.add),
        label: const Text('Neuer Bienenstand'),
      ),
      body: FutureBuilder<_ApiaryListData>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final filteredApiaries = _filterApiaries(data.apiaries);
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filteredApiaries.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _ApiarySearch(
                  controller: _searchController,
                  query: _searchQuery,
                  resultCount: filteredApiaries.length,
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                );
              }

              final apiary = filteredApiaries[index - 1];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(apiary.name),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(apiary.location),
                        Text(
                          '${data.hivesForApiary(apiary.id).length} Voelker',
                        ),
                        if (apiary.notes.isNotEmpty) Text(apiary.notes),
                      ],
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      AppRoutes.apiaryDetail,
                      arguments: apiary.id,
                    );
                    await _reload();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openCreateApiary() async {
    debugPrint('ApiaryListScreen: opening create apiary form');
    final changed = await Navigator.pushNamed(context, AppRoutes.apiaryForm);
    debugPrint('ApiaryListScreen: returned from apiary form changed=$changed');
    if (changed == true && mounted) {
      await _reload();
    }
  }

  List<BeeStand> _filterApiaries(List<BeeStand> apiaries) {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return apiaries;
    }

    return apiaries.where((apiary) {
      return apiary.name.toLowerCase().contains(query) ||
          apiary.location.toLowerCase().contains(query) ||
          apiary.notes.toLowerCase().contains(query);
    }).toList();
  }
}

class _ApiaryListData {
  const _ApiaryListData({required this.apiaries, required this.hives});

  final List<BeeStand> apiaries;
  final List<Hive> hives;

  List<Hive> hivesForApiary(String apiaryId) {
    return hives.where((hive) => hive.beeStandId == apiaryId).toList();
  }
}

class _ApiarySearch extends StatelessWidget {
  const _ApiarySearch({
    required this.controller,
    required this.query,
    required this.resultCount,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String query;
  final int resultCount;
  final ValueChanged<String> onChanged;

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
                    'Bienenstaende suchen',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text('$resultCount Treffer'),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Name, Standort oder Notizen suchen',
                border: const OutlineInputBorder(),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          controller.clear();
                          onChanged('');
                        },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Suche leeren',
                      ),
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
