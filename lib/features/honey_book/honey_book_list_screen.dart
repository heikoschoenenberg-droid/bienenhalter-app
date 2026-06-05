import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/honey_book_entry.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';
import '../../core/services/honey_book_export_service.dart';

class HoneyBookListScreen extends StatefulWidget {
  const HoneyBookListScreen({super.key});

  @override
  State<HoneyBookListScreen> createState() => _HoneyBookListScreenState();
}

class _HoneyBookListScreenState extends State<HoneyBookListScreen>
    with AppDataListener<HoneyBookListScreen> {
  final _searchController = TextEditingController();
  late Future<List<HoneyBookEntry>> _future;
  String _searchQuery = '';
  int? _yearFilter;
  String? _honeyTypeFilter;
  HoneyProcessingType? _processingFilter;

  @override
  void initState() {
    super.initState();
    _future = _loadEntries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void onAppDataChanged() {
    _reload();
  }

  Future<List<HoneyBookEntry>> _loadEntries() {
    return AppRepositories.instance.honeyBook.listHoneyBookEntries();
  }

  Future<void> _reload() async {
    if (!mounted) {
      return;
    }
    final future = _loadEntries();
    setState(() {
      _future = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Honigbuch')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateForm,
        icon: const Icon(Icons.add),
        label: const Text('Neuer Eintrag'),
      ),
      body: FutureBuilder<List<HoneyBookEntry>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data!;
          final filteredEntries = _filterEntries(entries);
          final years = _years(entries);
          final honeyTypes = _honeyTypes(entries);

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filteredEntries.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton.icon(
                      onPressed: _exportExcel,
                      icon: const Icon(Icons.table_chart),
                      label: const Text('Excel exportieren'),
                    ),
                    const SizedBox(height: 12),
                    _HoneyBookFilters(
                      controller: _searchController,
                      query: _searchQuery,
                      resultCount: filteredEntries.length,
                      years: years,
                      honeyTypes: honeyTypes,
                      yearFilter: _yearFilter,
                      honeyTypeFilter: _honeyTypeFilter,
                      processingFilter: _processingFilter,
                      onSearchChanged: (value) =>
                          setState(() => _searchQuery = value),
                      onYearChanged: (value) =>
                          setState(() => _yearFilter = value),
                      onHoneyTypeChanged: (value) =>
                          setState(() => _honeyTypeFilter = value),
                      onProcessingChanged: (value) =>
                          setState(() => _processingFilter = value),
                      onClear: _clearFilters,
                    ),
                  ],
                );
              }

              final entry = filteredEntries[index - 1];
              return _HoneyBookEntryCard(
                entry: entry,
                onTap: () => _openDetail(entry.id),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _openCreateForm() async {
    final changed = await Navigator.pushNamed(context, AppRoutes.honeyBookForm);
    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _exportExcel() async {
    try {
      final entries = await _loadEntries();
      final path = await const HoneyBookExportService().exportExcel(entries);
      if (!mounted) {
        return;
      }
      if (path == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export wurde abgebrochen.')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Honigbuch wurde exportiert: $path')),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Export fehlgeschlagen: $error')));
    }
  }

  Future<void> _openDetail(String entryId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.honeyBookDetail,
      arguments: entryId,
    );
    if (changed == true && mounted) {
      await _reload();
    }
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _yearFilter = null;
      _honeyTypeFilter = null;
      _processingFilter = null;
    });
  }

  List<HoneyBookEntry> _filterEntries(List<HoneyBookEntry> entries) {
    final query = _searchQuery.trim().toLowerCase();
    return entries.where((entry) {
      final matchesQuery =
          query.isEmpty ||
          entry.honeyType.toLowerCase().contains(query) ||
          entry.extractionLocation.toLowerCase().contains(query) ||
          entry.batchNumber.toLowerCase().contains(query) ||
          entry.notes.toLowerCase().contains(query);
      final matchesYear =
          _yearFilter == null || entry.harvestDate.year == _yearFilter;
      final matchesHoneyType =
          _honeyTypeFilter == null || entry.honeyType == _honeyTypeFilter;
      final matchesProcessing =
          _processingFilter == null ||
          entry.processingType == _processingFilter;

      return matchesQuery &&
          matchesYear &&
          matchesHoneyType &&
          matchesProcessing;
    }).toList();
  }

  List<int> _years(List<HoneyBookEntry> entries) {
    return entries.map((entry) => entry.harvestDate.year).toSet().toList()
      ..sort((a, b) => b.compareTo(a));
  }

  List<String> _honeyTypes(List<HoneyBookEntry> entries) {
    return entries.map((entry) => entry.honeyType).toSet().toList()..sort();
  }
}

class _HoneyBookFilters extends StatelessWidget {
  const _HoneyBookFilters({
    required this.controller,
    required this.query,
    required this.resultCount,
    required this.years,
    required this.honeyTypes,
    required this.yearFilter,
    required this.honeyTypeFilter,
    required this.processingFilter,
    required this.onSearchChanged,
    required this.onYearChanged,
    required this.onHoneyTypeChanged,
    required this.onProcessingChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final String query;
  final int resultCount;
  final List<int> years;
  final List<String> honeyTypes;
  final int? yearFilter;
  final String? honeyTypeFilter;
  final HoneyProcessingType? processingFilter;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<int?> onYearChanged;
  final ValueChanged<String?> onHoneyTypeChanged;
  final ValueChanged<HoneyProcessingType?> onProcessingChanged;
  final VoidCallback onClear;

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
                    'Honigbuch durchsuchen',
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
                labelText: 'Honigsorte, Schleuderort, Losnummer, Bemerkungen',
                border: const OutlineInputBorder(),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          controller.clear();
                          onSearchChanged('');
                        },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Suche leeren',
                      ),
              ),
              onChanged: onSearchChanged,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField<int?>(
                    initialValue: yearFilter,
                    decoration: const InputDecoration(
                      labelText: 'Jahr',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Alle')),
                      for (final year in years)
                        DropdownMenuItem(value: year, child: Text('$year')),
                    ],
                    onChanged: onYearChanged,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: DropdownButtonFormField<String?>(
                    initialValue: honeyTypeFilter,
                    decoration: const InputDecoration(
                      labelText: 'Honigsorte',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Alle')),
                      for (final type in honeyTypes)
                        DropdownMenuItem(value: type, child: Text(type)),
                    ],
                    onChanged: onHoneyTypeChanged,
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: DropdownButtonFormField<HoneyProcessingType?>(
                    initialValue: processingFilter,
                    decoration: const InputDecoration(
                      labelText: 'Verarbeitung',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Alle')),
                      for (final type in HoneyProcessingType.values)
                        DropdownMenuItem(value: type, child: Text(type.label)),
                    ],
                    onChanged: onProcessingChanged,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: onClear,
                  icon: const Icon(Icons.filter_alt_off),
                  label: const Text('Filter leeren'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HoneyBookEntryCard extends StatelessWidget {
  const _HoneyBookEntryCard({required this.entry, required this.onTap});

  final HoneyBookEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          entry.runningNumber.isEmpty
              ? entry.honeyType
              : '${entry.runningNumber} - ${entry.honeyType}',
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text(formatDate(entry.harvestDate))),
              Chip(label: Text('${entry.amountKg.toStringAsFixed(1)} kg')),
              if (entry.waterContentPercent != null)
                Chip(
                  label: Text(
                    '${entry.waterContentPercent!.toStringAsFixed(1)} % Wasser',
                  ),
                ),
              if (entry.batchNumber.isNotEmpty)
                Chip(label: Text('Los ${entry.batchNumber}')),
              if (entry.bestBeforeDate != null)
                Chip(label: Text('MHD ${formatDate(entry.bestBeforeDate)}')),
              Chip(label: Text(entry.processingType.label)),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
