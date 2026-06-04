import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';

class InspectionHistoryScreen extends StatefulWidget {
  const InspectionHistoryScreen({super.key, required this.hiveId});

  final String? hiveId;

  @override
  State<InspectionHistoryScreen> createState() =>
      _InspectionHistoryScreenState();
}

class _InspectionHistoryScreenState extends State<InspectionHistoryScreen>
    with AppDataListener<InspectionHistoryScreen> {
  final _searchController = TextEditingController();
  late Future<_InspectionHistoryData> _future;

  String _searchQuery = '';
  String? _apiaryFilterId;
  String? _hiveFilterId;
  _InspectionTimeRange _timeRange = _InspectionTimeRange.all;
  _BoolFilter _queenSeenFilter = _BoolFilter.all;
  _BoolFilter _varroaFilter = _BoolFilter.all;
  _BoolFilter _beeEscapeFilter = _BoolFilter.all;

  @override
  void initState() {
    super.initState();
    _hiveFilterId = widget.hiveId;
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

  Future<_InspectionHistoryData> _loadData() async {
    final repositories = AppRepositories.instance;
    final hives = await repositories.hives.getAll();
    final apiaries = await repositories.apiaries.getAll();
    final inspections = widget.hiveId == null
        ? await repositories.inspections.getAll()
        : await repositories.inspections.getForHive(widget.hiveId!);

    return _InspectionHistoryData(
      apiaries: apiaries,
      hives: hives,
      inspections: inspections,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontrollhistorie')),
      body: FutureBuilder<_InspectionHistoryData>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final filteredInspections = _filterInspections(data);

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: filteredInspections.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _InspectionFilters(
                  searchController: _searchController,
                  searchQuery: _searchQuery,
                  apiaries: data.apiaries,
                  hives: data.hives,
                  apiaryFilterId: _apiaryFilterId,
                  hiveFilterId: _hiveFilterId,
                  timeRange: _timeRange,
                  queenSeenFilter: _queenSeenFilter,
                  varroaFilter: _varroaFilter,
                  beeEscapeFilter: _beeEscapeFilter,
                  resultCount: filteredInspections.length,
                  hiveFilterLocked: widget.hiveId != null,
                  onSearchChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                  onApiaryChanged: (value) {
                    setState(() {
                      _apiaryFilterId = value;
                      if (value != null &&
                          _hiveFilterId != null &&
                          data.hiveById(_hiveFilterId!).beeStandId != value) {
                        _hiveFilterId = null;
                      }
                    });
                  },
                  onHiveChanged: (value) {
                    setState(() => _hiveFilterId = value);
                  },
                  onTimeRangeChanged: (value) {
                    setState(() => _timeRange = value);
                  },
                  onQueenSeenChanged: (value) {
                    setState(() => _queenSeenFilter = value);
                  },
                  onVarroaChanged: (value) {
                    setState(() => _varroaFilter = value);
                  },
                  onBeeEscapeChanged: (value) {
                    setState(() => _beeEscapeFilter = value);
                  },
                );
              }

              final inspection = filteredInspections[index - 1];
              final hive = data.hiveById(inspection.hiveId);
              final apiary = data.apiaryById(hive.beeStandId);

              return _InspectionHistoryCard(
                inspection: inspection,
                hive: hive,
                apiary: apiary,
                onTap: () async {
                  final changed = await Navigator.pushNamed(
                    context,
                    AppRoutes.inspectionDetail,
                    arguments: inspection.id,
                  );
                  if (changed == true && mounted) {
                    await _reload();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }

  List<Inspection> _filterInspections(_InspectionHistoryData data) {
    final query = _searchQuery.trim().toLowerCase();

    return data.inspections.where((inspection) {
      final hive = data.hiveById(inspection.hiveId);
      final apiary = data.apiaryById(hive.beeStandId);
      final matchesSearch =
          query.isEmpty ||
          hive.number.toLowerCase().contains(query) ||
          hive.name.toLowerCase().contains(query) ||
          apiary.name.toLowerCase().contains(query) ||
          apiary.location.toLowerCase().contains(query) ||
          inspection.notes.toLowerCase().contains(query) ||
          inspection.varroaTreatment.toLowerCase().contains(query) ||
          inspection.feedType.toLowerCase().contains(query);
      final matchesApiary =
          _apiaryFilterId == null || hive.beeStandId == _apiaryFilterId;
      final matchesHive = _hiveFilterId == null || hive.id == _hiveFilterId;
      final matchesTimeRange = _matchesTimeRange(inspection.date);
      final matchesQueenSeen = _matchesBool(
        filter: _queenSeenFilter,
        value: inspection.queenSeen,
      );
      final matchesVarroa = _matchesBool(
        filter: _varroaFilter,
        value: inspection.varroaTreatmentDone,
      );
      final matchesBeeEscape = _matchesBool(
        filter: _beeEscapeFilter,
        value: inspection.beeEscapeInserted,
      );

      return matchesSearch &&
          matchesApiary &&
          matchesHive &&
          matchesTimeRange &&
          matchesQueenSeen &&
          matchesVarroa &&
          matchesBeeEscape;
    }).toList();
  }

  bool _matchesTimeRange(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final inspectionDay = DateTime(date.year, date.month, date.day);

    return switch (_timeRange) {
      _InspectionTimeRange.all => true,
      _InspectionTimeRange.today => inspectionDay == today,
      _InspectionTimeRange.last7Days => !inspectionDay.isBefore(
        today.subtract(const Duration(days: 6)),
      ),
      _InspectionTimeRange.lastMonth => !inspectionDay.isBefore(
        DateTime(now.year, now.month - 1, now.day),
      ),
      _InspectionTimeRange.thisYear => date.year == now.year,
    };
  }

  bool _matchesBool({required _BoolFilter filter, required bool value}) {
    return switch (filter) {
      _BoolFilter.all => true,
      _BoolFilter.yes => value,
      _BoolFilter.no => !value,
    };
  }
}

class _InspectionHistoryData {
  const _InspectionHistoryData({
    required this.apiaries,
    required this.hives,
    required this.inspections,
  });

  final List<BeeStand> apiaries;
  final List<Hive> hives;
  final List<Inspection> inspections;

  Hive hiveById(String id) {
    return hives.firstWhere((hive) => hive.id == id);
  }

  BeeStand apiaryById(String id) {
    return apiaries.firstWhere((apiary) => apiary.id == id);
  }
}

enum _InspectionTimeRange { all, today, last7Days, lastMonth, thisYear }

enum _BoolFilter { all, yes, no }

class _InspectionFilters extends StatelessWidget {
  const _InspectionFilters({
    required this.searchController,
    required this.searchQuery,
    required this.apiaries,
    required this.hives,
    required this.apiaryFilterId,
    required this.hiveFilterId,
    required this.timeRange,
    required this.queenSeenFilter,
    required this.varroaFilter,
    required this.beeEscapeFilter,
    required this.resultCount,
    required this.hiveFilterLocked,
    required this.onSearchChanged,
    required this.onApiaryChanged,
    required this.onHiveChanged,
    required this.onTimeRangeChanged,
    required this.onQueenSeenChanged,
    required this.onVarroaChanged,
    required this.onBeeEscapeChanged,
  });

  final TextEditingController searchController;
  final String searchQuery;
  final List<BeeStand> apiaries;
  final List<Hive> hives;
  final String? apiaryFilterId;
  final String? hiveFilterId;
  final _InspectionTimeRange timeRange;
  final _BoolFilter queenSeenFilter;
  final _BoolFilter varroaFilter;
  final _BoolFilter beeEscapeFilter;
  final int resultCount;
  final bool hiveFilterLocked;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onApiaryChanged;
  final ValueChanged<String?> onHiveChanged;
  final ValueChanged<_InspectionTimeRange> onTimeRangeChanged;
  final ValueChanged<_BoolFilter> onQueenSeenChanged;
  final ValueChanged<_BoolFilter> onVarroaChanged;
  final ValueChanged<_BoolFilter> onBeeEscapeChanged;

  @override
  Widget build(BuildContext context) {
    final selectableHives = hiveFilterLocked || apiaryFilterId == null
        ? hives
        : hives.where((hive) => hive.beeStandId == apiaryFilterId).toList();

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
                    'Kontrollen suchen und filtern',
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
                labelText: 'Volk, Stand, Notiz, Behandlung oder Futter suchen',
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
              key: ValueKey('inspection-apiary-${apiaryFilterId ?? 'all'}'),
              initialValue: apiaryFilterId ?? 'all',
              decoration: const InputDecoration(
                labelText: 'Bienenstand',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Alle')),
                for (final apiary in apiaries)
                  DropdownMenuItem(
                    value: apiary.id,
                    child: Text('${apiary.name} - ${apiary.location}'),
                  ),
              ],
              onChanged: (value) {
                onApiaryChanged(value == null || value == 'all' ? null : value);
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('inspection-hive-${hiveFilterId ?? 'all'}'),
              initialValue: hiveFilterId ?? 'all',
              decoration: const InputDecoration(
                labelText: 'Volk',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Alle')),
                for (final hive in selectableHives)
                  DropdownMenuItem(value: hive.id, child: Text(hive.number)),
              ],
              onChanged: hiveFilterLocked
                  ? null
                  : (value) {
                      onHiveChanged(
                        value == null || value == 'all' ? null : value,
                      );
                    },
            ),
            const SizedBox(height: 12),
            _EnumDropdown<_InspectionTimeRange>(
              keyPrefix: 'inspection-time',
              label: 'Zeitraum',
              value: timeRange,
              values: _InspectionTimeRange.values,
              labelFor: _timeRangeLabel,
              onChanged: onTimeRangeChanged,
            ),
            const SizedBox(height: 12),
            _EnumDropdown<_BoolFilter>(
              keyPrefix: 'inspection-queen',
              label: 'Koenigin gesehen',
              value: queenSeenFilter,
              values: _BoolFilter.values,
              labelFor: _boolLabel,
              onChanged: onQueenSeenChanged,
            ),
            const SizedBox(height: 12),
            _EnumDropdown<_BoolFilter>(
              keyPrefix: 'inspection-varroa',
              label: 'Varroabehandlung',
              value: varroaFilter,
              values: _BoolFilter.values,
              labelFor: (value) => _boolDoneLabel(value, 'durchgefuehrt'),
              onChanged: onVarroaChanged,
            ),
            const SizedBox(height: 12),
            _EnumDropdown<_BoolFilter>(
              keyPrefix: 'inspection-bee-escape',
              label: 'Bienenflucht',
              value: beeEscapeFilter,
              values: _BoolFilter.values,
              labelFor: (value) => _boolDoneLabel(value, 'eingelegt'),
              onChanged: onBeeEscapeChanged,
            ),
          ],
        ),
      ),
    );
  }

  String _timeRangeLabel(_InspectionTimeRange value) {
    return switch (value) {
      _InspectionTimeRange.all => 'Alle',
      _InspectionTimeRange.today => 'Heute',
      _InspectionTimeRange.last7Days => 'Letzte 7 Tage',
      _InspectionTimeRange.lastMonth => 'Letzter Monat',
      _InspectionTimeRange.thisYear => 'Dieses Jahr',
    };
  }

  String _boolLabel(_BoolFilter value) {
    return switch (value) {
      _BoolFilter.all => 'Alle',
      _BoolFilter.yes => 'Ja',
      _BoolFilter.no => 'Nein',
    };
  }

  String _boolDoneLabel(_BoolFilter value, String yesLabel) {
    return switch (value) {
      _BoolFilter.all => 'Alle',
      _BoolFilter.yes => yesLabel,
      _BoolFilter.no => 'nicht $yesLabel',
    };
  }
}

class _EnumDropdown<T extends Enum> extends StatelessWidget {
  const _EnumDropdown({
    required this.keyPrefix,
    required this.label,
    required this.value,
    required this.values,
    required this.labelFor,
    required this.onChanged,
  });

  final String keyPrefix;
  final String label;
  final T value;
  final List<T> values;
  final String Function(T value) labelFor;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      key: ValueKey('$keyPrefix-${value.name}'),
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: [
        for (final item in values)
          DropdownMenuItem(value: item, child: Text(labelFor(item))),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}

class _InspectionHistoryCard extends StatelessWidget {
  const _InspectionHistoryCard({
    required this.inspection,
    required this.hive,
    required this.apiary,
    required this.onTap,
  });

  final Inspection inspection;
  final Hive hive;
  final BeeStand apiary;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    final note = inspection.notes.isEmpty ? 'Keine Notiz' : inspection.notes;

    return Card(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.fact_check_outlined),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formatDateTime(inspection.date),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text('${hive.number} - ${apiary.name}'),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('Stimmung: ${inspection.mood}')),
                  Chip(
                    label: Text(
                      inspection.queenSeen
                          ? 'Koenigin gesehen'
                          : 'Koenigin nicht gesehen',
                    ),
                  ),
                  Chip(label: Text('Staerke: ${inspection.colonyStrength}/10')),
                  Chip(
                    label: Text('Brutrahmen: ${inspection.broodFrameCount}'),
                  ),
                  Chip(
                    label: Text(
                      'Honigraeume: ${inspection.honeySuperCount}, '
                      '${inspection.honeySuperFillLevel}',
                    ),
                  ),
                  Chip(
                    label: Text(
                      inspection.varroaTreatmentDone
                          ? 'Varroa: ${inspection.varroaTreatment}'
                          : 'Varroa: nein',
                    ),
                  ),
                  Chip(
                    label: Text(
                      inspection.beeEscapeInserted
                          ? 'Bienenflucht eingelegt'
                          : 'Bienenflucht nein',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(note),
            ],
          ),
        ),
      ),
    );
  }
}
