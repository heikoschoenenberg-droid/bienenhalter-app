import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/services/app_repositories.dart';

class InspectionHistoryScreen extends StatelessWidget {
  const InspectionHistoryScreen({super.key, required this.hiveId});

  final String? hiveId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kontrollhistorie')),
      body: FutureBuilder<_InspectionHistoryData>(
        future: _loadData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.inspections.length + 1,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.selectedHive == null
                          ? 'Kontrollhistorie'
                          : data.selectedHive!.number,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('Lokal gespeicherte Kontrollen.'),
                  ],
                );
              }

              final inspection = data.inspections[index - 1];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _InspectionHistoryItem(
                    inspection: inspection,
                    hive: data.hiveById(inspection.hiveId),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<_InspectionHistoryData> _loadData() async {
    final repositories = AppRepositories.instance;
    final hives = await repositories.hives.getAll();
    final inspections = hiveId == null
        ? await repositories.inspections.getAll()
        : await repositories.inspections.getForHive(hiveId!);
    final selectedHive = hiveId == null
        ? null
        : hives.firstWhere((hive) => hive.id == hiveId);

    return _InspectionHistoryData(
      hives: hives,
      selectedHive: selectedHive,
      inspections: inspections,
    );
  }
}

class _InspectionHistoryData {
  const _InspectionHistoryData({
    required this.hives,
    required this.selectedHive,
    required this.inspections,
  });

  final List<Hive> hives;
  final Hive? selectedHive;
  final List<Inspection> inspections;

  Hive hiveById(String id) {
    return hives.firstWhere((hive) => hive.id == id);
  }
}

class _InspectionHistoryItem extends StatelessWidget {
  const _InspectionHistoryItem({required this.inspection, required this.hive});

  final Inspection inspection;
  final Hive hive;

  @override
  Widget build(BuildContext context) {
    final note = inspection.notes.isEmpty ? 'Keine Notiz' : inspection.notes;

    return Column(
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
                  Text(hive.number),
                ],
              ),
            ),
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
          ],
        ),
        const SizedBox(height: 12),
        Text(note),
      ],
    );
  }
}
