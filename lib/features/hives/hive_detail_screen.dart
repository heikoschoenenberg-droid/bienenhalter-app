import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/beekeeper_task.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/services/app_repositories.dart';
import 'hive_form_screen.dart';
import '../tasks/task_form_screen.dart';

class HiveDetailScreen extends StatefulWidget {
  const HiveDetailScreen({super.key, required this.hiveId});

  final String? hiveId;

  @override
  State<HiveDetailScreen> createState() => _HiveDetailScreenState();
}

class _HiveDetailScreenState extends State<HiveDetailScreen> {
  late Future<_HiveDetailData> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  Future<_HiveDetailData> _loadData() async {
    final hiveId = widget.hiveId;
    if (hiveId == null) {
      throw StateError('Missing hive id');
    }

    final repositories = AppRepositories.instance;
    final hive = await repositories.hives.getById(hiveId);
    final beeStand = await repositories.apiaries.getById(hive.beeStandId);
    final inspections = await repositories.inspections.getForHive(hive.id);
    final openTasks = await repositories.tasks.getOpenForHive(hive.id);

    return _HiveDetailData(
      hive: hive,
      beeStand: beeStand,
      inspections: inspections,
      openTasks: openTasks,
    );
  }

  void _reload() {
    setState(() => _future = _loadData());
  }

  Future<void> _openTaskForm(String hiveId, {String? taskId}) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.taskForm,
      arguments: TaskFormArguments(taskId: taskId, initialHiveId: hiveId),
    );

    if (changed == true && mounted) {
      _reload();
    }
  }

  Future<void> _openHiveForm(String hiveId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.hiveForm,
      arguments: HiveFormArguments(hiveId: hiveId),
    );

    if (changed == true && mounted) {
      _reload();
    }
  }

  Future<void> _completeTask(String taskId) async {
    await AppRepositories.instance.tasks.complete(taskId);
    _reload();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aufgabe wurde als erledigt markiert.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hiveId == null) {
      return const _MissingHiveScreen();
    }

    return FutureBuilder<_HiveDetailData>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Volk')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!;
        final hive = data.hive;
        final latestInspection = data.inspections.isEmpty
            ? null
            : data.inspections.first;

        return Scaffold(
          appBar: AppBar(title: Text(hive.number)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                hive.number,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text('${data.beeStand.name} - ${data.beeStand.location}'),
              const SizedBox(height: 20),
              _ActionGrid(
                hiveId: hive.id,
                onCreateTask: () => _openTaskForm(hive.id),
                onEditHive: () => _openHiveForm(hive.id),
              ),
              const SizedBox(height: 20),
              _SectionCard(
                title: 'Stammdaten',
                children: [
                  _DetailRow(label: 'Bienenstand', value: data.beeStand.name),
                  _DetailRow(label: 'Standort', value: data.beeStand.location),
                  _DetailRow(label: 'Beutentyp', value: hive.hiveType),
                  _DetailRow(
                    label: 'Koeniginnenjahr',
                    value: hive.queenYear.toString(),
                  ),
                  _DetailRow(label: 'Koeniginnenfarbe', value: hive.queenColor),
                  _DetailRow(label: 'Herkunft', value: hive.queenOrigin),
                  _DetailRow(label: 'Status', value: hive.statusLabel),
                  if (hive.notes.isNotEmpty)
                    _DetailRow(label: 'Notizen', value: hive.notes),
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
                  if (data.openTasks.isEmpty)
                    const Text(
                      'Aktuell sind keine offenen Aufgaben hinterlegt.',
                    )
                  else
                    for (final task in data.openTasks)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Checkbox(
                          value: false,
                          onChanged: (_) => _completeTask(task.id),
                        ),
                        title: Text(task.title),
                        subtitle: Text(
                          '${task.categoryLabel} - faellig am '
                          '${formatDueDate(task.dueDate, task.dueTime)}',
                        ),
                        trailing: const Icon(Icons.edit),
                        onTap: () => _openTaskForm(hive.id, taskId: task.id),
                      ),
                ],
              ),
              const SizedBox(height: 12),
              _SectionCard(
                title: 'Verlauf',
                children: [
                  if (data.inspections.isEmpty)
                    const Text('Noch kein Verlauf vorhanden.')
                  else
                    for (final inspection in data.inspections.take(3))
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
      },
    );
  }
}

class _HiveDetailData {
  const _HiveDetailData({
    required this.hive,
    required this.beeStand,
    required this.inspections,
    required this.openTasks,
  });

  final Hive hive;
  final BeeStand beeStand;
  final List<Inspection> inspections;
  final List<BeekeeperTask> openTasks;
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({
    required this.hiveId,
    required this.onCreateTask,
    required this.onEditHive,
  });

  final String hiveId;
  final VoidCallback onCreateTask;
  final VoidCallback onEditHive;

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
            onPressed: onEditHive,
            icon: const Icon(Icons.edit),
            label: const Text('Bearbeiten'),
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
          label: 'Volksstaerke',
          value: '${inspection.colonyStrength}/10',
        ),
        _DetailRow(
          label: 'Brutrahmen',
          value: inspection.broodFrameCount.toString(),
        ),
        _DetailRow(
          label: 'Honigraumstatus',
          value:
              '${inspection.honeySuperCount}, ${inspection.honeySuperFillLevel}',
        ),
        _DetailRow(
          label: 'Varroa',
          value: inspection.varroaTreatmentDone
              ? inspection.varroaTreatment
              : 'nicht durchgefuehrt',
        ),
        _DetailRow(label: 'Auffaelligkeiten', value: _findingsText(inspection)),
        _DetailRow(label: 'Notizen', value: inspection.notes),
      ],
    );
  }

  String _findingsText(Inspection inspection) {
    final findings = <String>[];

    if (inspection.queenCellsSeen) {
      findings.add('Weiselzellen');
    }
    if (inspection.swarmCellsSeen) {
      findings.add('Schwarmzellen');
    }
    if (inspection.emergencyCellsSeen) {
      findings.add('Nachschaffungszellen');
    }
    if (inspection.cellsRemoved) {
      findings.add('Zellen entfernt');
    }
    if (inspection.beeEscapeInserted) {
      findings.add('Bienenflucht eingelegt');
    }

    return findings.isEmpty ? 'keine' : findings.join(', ');
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
