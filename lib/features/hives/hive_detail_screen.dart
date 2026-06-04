import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/demo/demo_data.dart';
import '../../core/models/inspection.dart';

class HiveDetailScreen extends StatelessWidget {
  const HiveDetailScreen({super.key, required this.hiveId});

  final String? hiveId;

  @override
  Widget build(BuildContext context) {
    if (hiveId == null) {
      return const _MissingHiveScreen();
    }

    final hive = DemoData.hiveById(hiveId!);
    final beeStand = DemoData.beeStandById(hive.beeStandId);
    final latestInspection = DemoData.latestInspectionForHive(hive.id);
    final openTasks = DemoData.openTasksForHive(hive.id);
    final inspections = DemoData.inspectionsForHive(hive.id);

    return Scaffold(
      appBar: AppBar(title: Text(hive.number)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(hive.number, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('${beeStand.name} - ${beeStand.location}'),
          const SizedBox(height: 20),
          _ActionGrid(
            hiveId: hive.id,
            onCreateTask: () => Navigator.pushNamed(context, AppRoutes.tasks),
          ),
          const SizedBox(height: 20),
          _SectionCard(
            title: 'Stammdaten',
            children: [
              _DetailRow(label: 'Bienenstand', value: beeStand.name),
              _DetailRow(label: 'Standort', value: beeStand.location),
              _DetailRow(
                label: 'Koeniginnenjahr',
                value: hive.queenYear.toString(),
              ),
              _DetailRow(label: 'Koeniginnenfarbe', value: hive.queenColor),
              _DetailRow(label: 'Status', value: hive.statusLabel),
            ],
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Letzte Kontrolle',
            children: [
              if (latestInspection == null)
                const Text('Noch keine Kontrolle erfasst.')
              else
                _InspectionSummary(inspection: latestInspection),
            ],
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Offene Aufgaben',
            children: [
              if (openTasks.isEmpty)
                const Text('Aktuell sind keine offenen Aufgaben hinterlegt.')
              else
                for (final task in openTasks)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.radio_button_unchecked),
                    title: Text(task.title),
                    subtitle: Text(
                      '${task.categoryLabel} - faellig am ${formatDate(task.dueDate)}',
                    ),
                  ),
            ],
          ),
          const SizedBox(height: 12),
          _SectionCard(
            title: 'Verlauf',
            children: [
              if (inspections.isEmpty)
                const Text('Noch kein Verlauf vorhanden.')
              else
                for (final inspection in inspections.take(3))
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.history),
                    title: Text(formatDateTime(inspection.date)),
                    subtitle: Text(inspection.notes),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.hiveId, required this.onCreateTask});

  final String hiveId;
  final VoidCallback onCreateTask;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 560;
        final actions = [
          FilledButton.icon(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.inspectionCreate,
              arguments: hiveId,
            ),
            icon: const Icon(Icons.add_task),
            label: const Text('Neue Kontrolle'),
          ),
          OutlinedButton.icon(
            onPressed: onCreateTask,
            icon: const Icon(Icons.add),
            label: const Text('Aufgabe anlegen'),
          ),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.inspectionHistory,
              arguments: hiveId,
            ),
            icon: const Icon(Icons.history),
            label: const Text('Historie anzeigen'),
          ),
        ];

        if (isNarrow) {
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InspectionSummary extends StatelessWidget {
  const _InspectionSummary({required this.inspection});

  final Inspection inspection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatDateTime(inspection.date),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        _DetailRow(label: 'Gemutszustand', value: inspection.mood),
        _DetailRow(
          label: 'Koenigin gesehen',
          value: inspection.queenSeen ? 'Ja' : 'Nein',
        ),
        _DetailRow(label: 'Wabensitz', value: inspection.combPosition),
        _DetailRow(
          label: 'Weiselzellen',
          value: inspection.queenCellsSeen ? 'gesehen' : 'keine',
        ),
        _DetailRow(
          label: 'Schwarmzellen',
          value: inspection.swarmCellsSeen ? 'gesehen' : 'keine',
        ),
        _DetailRow(
          label: 'Nachschaffung',
          value: inspection.emergencyCellsSeen ? 'gesehen' : 'keine',
        ),
        _DetailRow(label: 'Volksstaerke', value: inspection.colonyStrength),
        _DetailRow(
          label: 'Brutrahmen',
          value: inspection.broodFrameCount.toString(),
        ),
        _DetailRow(
          label: 'Honigraeume',
          value:
              '${inspection.honeySuperCount}, ${inspection.honeySuperFillLevel}',
        ),
        _DetailRow(label: 'Notizen', value: inspection.notes),
      ],
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
            width: 150,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _MissingHiveScreen extends StatelessWidget {
  const _MissingHiveScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Volk nicht gefunden')),
      body: const Center(
        child: Text('Fuer diese Ansicht wurde kein Volk ausgewaehlt.'),
      ),
    );
  }
}
