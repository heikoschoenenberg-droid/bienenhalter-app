import 'package:flutter/material.dart';

import '../../core/date_format.dart';
import '../../core/demo/demo_data.dart';
import '../../core/models/inspection.dart';

class InspectionHistoryScreen extends StatelessWidget {
  const InspectionHistoryScreen({super.key, required this.hiveId});

  final String? hiveId;

  @override
  Widget build(BuildContext context) {
    final hive = hiveId == null ? null : DemoData.hiveById(hiveId!);
    final inspections = hiveId == null
        ? _sortedInspections(DemoData.inspections)
        : DemoData.inspectionsForHive(hiveId!);

    return Scaffold(
      appBar: AppBar(title: const Text('Kontrollhistorie')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: inspections.length + 1,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hive == null ? 'Kontrollhistorie' : hive.number,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text('Erfasste und vorbereitete Demo-Kontrollen.'),
              ],
            );
          }

          final inspection = inspections[index - 1];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _InspectionHistoryItem(inspection: inspection),
            ),
          );
        },
      ),
    );
  }

  List<Inspection> _sortedInspections(List<Inspection> inspections) {
    return [...inspections]..sort((a, b) => b.date.compareTo(a.date));
  }
}

class _InspectionHistoryItem extends StatelessWidget {
  const _InspectionHistoryItem({required this.inspection});

  final Inspection inspection;

  @override
  Widget build(BuildContext context) {
    final hive = DemoData.hiveById(inspection.hiveId);
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
