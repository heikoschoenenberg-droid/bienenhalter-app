import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/demo/demo_data.dart';
import '../../core/models/hive.dart';

class HiveListScreen extends StatelessWidget {
  const HiveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hives = DemoData.hives;

    return Scaffold(
      appBar: AppBar(title: const Text('Voelker')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: hives.length + 1,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _HiveFilterPlaceholder();
          }

          final hive = hives[index - 1];
          return _HiveCard(hive: hive);
        },
      ),
    );
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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
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
  const _HiveCard({required this.hive});

  final Hive hive;

  @override
  Widget build(BuildContext context) {
    final beeStand = DemoData.beeStandById(hive.beeStandId);
    final latestInspection = DemoData.latestInspectionForHive(hive.id);
    final warnings = DemoData.warningsForHive(hive.id);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.hiveDetail,
          arguments: hive.id,
        ),
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
                    label: formatDate(latestInspection?.date),
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
      HiveStatus.needsAttention => colorScheme.tertiaryContainer,
      HiveStatus.inactive => colorScheme.surfaceContainerHighest,
    };

    return Chip(
      label: Text(status.statusLabel),
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

extension on HiveStatus {
  String get statusLabel {
    return switch (this) {
      HiveStatus.active => 'Aktiv',
      HiveStatus.needsAttention => 'Beobachten',
      HiveStatus.inactive => 'Inaktiv',
    };
  }
}
