import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/beekeeper_task.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/services/app_repositories.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienenhalter-App')),
      body: FutureBuilder<_DashboardData>(
        future: _loadDashboardData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Dein Ueberblick fuer die naechsten Kontrollen.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              _MetricGrid(
                children: [
                  _MetricCard(
                    title: 'Aktive Voelker',
                    value: data.activeHives.toString(),
                    icon: Icons.hive_outlined,
                  ),
                  _MetricCard(
                    title: 'Offene Aufgaben',
                    value: data.openTasks.toString(),
                    icon: Icons.task_alt,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Letzte Kontrolle',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (data.latestInspection == null)
                        const Text('Es wurde noch keine Kontrolle erfasst.')
                      else ...[
                        Text(
                          '${data.latestHive?.number ?? 'Unbekanntes Volk'} am '
                          '${formatDate(data.latestInspection!.date)}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(data.latestInspection!.notes),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.hives),
                icon: const Icon(Icons.list_alt),
                label: const Text('Voelker ansehen'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.tasks),
                icon: const Icon(Icons.checklist),
                label: const Text('Aufgaben oeffnen'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<_DashboardData> _loadDashboardData() async {
    final repositories = AppRepositories.instance;
    final hives = await repositories.hives.getAll();
    final tasks = await repositories.tasks.getAllSorted();
    final latestInspection = await repositories.inspections.latest();
    final latestHive = latestInspection == null
        ? null
        : await repositories.hives.getById(latestInspection.hiveId);

    return _DashboardData(
      activeHives: hives
          .where((hive) => hive.status != HiveStatus.inactive)
          .length,
      openTasks: tasks
          .where((task) => task.status == BeekeeperTaskStatus.open)
          .length,
      latestInspection: latestInspection,
      latestHive: latestHive,
    );
  }
}

class _DashboardData {
  const _DashboardData({
    required this.activeHives,
    required this.openTasks,
    required this.latestInspection,
    required this.latestHive,
  });

  final int activeHives;
  final int openTasks;
  final Inspection? latestInspection;
  final Hive? latestHive;
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520) {
          return Column(
            children: [
              for (final child in children) ...[
                child,
                if (child != children.last) const SizedBox(height: 12),
              ],
            ],
          );
        }

        return Row(
          children: [
            for (final child in children) ...[
              Expanded(child: child),
              if (child != children.last) const SizedBox(width: 12),
            ],
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.primary, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
