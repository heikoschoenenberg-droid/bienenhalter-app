import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/beekeeper_task.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/models/photo_attachment.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';
import '../../core/widgets/photo_preview.dart';
import 'hive_form_screen.dart';
import '../inspections/inspection_create_screen.dart';
import '../tasks/task_form_screen.dart';

class HiveDetailScreen extends StatefulWidget {
  const HiveDetailScreen({super.key, required this.hiveId});

  final String? hiveId;

  @override
  State<HiveDetailScreen> createState() => _HiveDetailScreenState();
}

class _HiveDetailScreenState extends State<HiveDetailScreen>
    with AppDataListener<HiveDetailScreen> {
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
    final photos = await repositories.photos.getForHive(hive.id);
    final latestInspectionPhotos = inspections.isEmpty
        ? <PhotoAttachment>[]
        : await repositories.photos.getForInspection(inspections.first.id);

    return _HiveDetailData(
      hive: hive,
      beeStand: beeStand,
      inspections: inspections,
      openTasks: openTasks,
      photos: photos,
      latestInspectionPhotos: latestInspectionPhotos,
    );
  }

  Future<void> _reload() async {
    if (!mounted) {
      return;
    }
    debugPrint('HiveDetailScreen: reload requested');
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

  Future<void> _openTaskForm(String hiveId, {String? taskId}) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.taskForm,
      arguments: TaskFormArguments(taskId: taskId, initialHiveId: hiveId),
    );

    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _openHiveForm(String hiveId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.hiveForm,
      arguments: HiveFormArguments(hiveId: hiveId),
    );

    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _openInspectionForm(String hiveId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.inspectionCreate,
      arguments: hiveId,
    );

    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _openInspectionHistory(String hiveId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.inspectionHistory,
      arguments: hiveId,
    );

    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _openInspectionDetail(String inspectionId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.inspectionDetail,
      arguments: inspectionId,
    );

    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _openInspectionEditForm(Inspection inspection) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.inspectionCreate,
      arguments: InspectionFormArguments(
        hiveId: inspection.hiveId,
        inspectionId: inspection.id,
      ),
    );

    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _confirmDeleteInspection(Inspection inspection) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kontrolle löschen?'),
          content: const Text('Möchtest du diese Kontrolle wirklich löschen?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Loeschen'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await AppRepositories.instance.inspections.deleteInspection(inspection.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kontrolle wurde gelöscht.')));
    await _reload();
  }

  Future<void> _completeTask(String taskId) async {
    debugPrint('HiveDetailScreen: completing task $taskId');
    await AppRepositories.instance.tasks.complete(taskId);
    debugPrint('HiveDetailScreen: completed task $taskId');
    await _reload();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aufgabe wurde als erledigt markiert.')),
    );
  }

  Future<void> _pickHivePhotos(String hiveId) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: false,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final now = DateTime.now();
    var index = 0;
    final photos = result.files.map((file) {
      return PhotoAttachment(
        id: 'photo-${now.microsecondsSinceEpoch}-${index++}',
        localPath: file.path ?? file.name,
        filename: file.name,
        linkedHiveId: hiveId,
        linkedInspectionId: null,
        type: PhotoAttachmentType.hivePhoto,
        createdAt: now,
        notes: '',
      );
    });

    await AppRepositories.instance.photos.upsertAll(photos);
    if (mounted) {
      await _reload();
    }
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
              _HiveHeader(
                hive: hive,
                beeStand: data.beeStand,
                primaryPhoto: data.photos.isEmpty ? null : data.photos.first,
              ),
              const SizedBox(height: 16),
              _ActionGrid(
                onCreateTask: () => _openTaskForm(hive.id),
                onEditHive: () => _openHiveForm(hive.id),
                onCreateInspection: () => _openInspectionForm(hive.id),
                onOpenHistory: () => _openInspectionHistory(hive.id),
                onOpenLatestInspection: latestInspection == null
                    ? null
                    : () => _openInspectionDetail(latestInspection.id),
              ),
              const SizedBox(height: 20),
              _SectionCard(
                title: 'Stammdaten',
                children: [
                  _DetailRow(label: 'Bienenstand', value: data.beeStand.name),
                  _DetailRow(label: 'Standort', value: data.beeStand.location),
                  _DetailRow(label: 'Beutentyp', value: hive.hiveType),
                  _DetailRow(
                    label: 'Königinnenjahr',
                    value: hive.queenYear.toString(),
                  ),
                  _DetailRow(
                    label: 'Königinnenfarbe',
                    value: _queenColorLabel(hive.queenColor),
                  ),
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
                    _InspectionSummary(
                      inspection: latestInspection,
                      photos: data.latestInspectionPhotos,
                      onEdit: () => _openInspectionEditForm(latestInspection),
                      onOpenPhotos: () =>
                          _openInspectionDetail(latestInspection.id),
                      onDelete: () =>
                          _confirmDeleteInspection(latestInspection),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              _SectionCard(
                title: 'Fotos vom Volk',
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _pickHivePhotos(hive.id),
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                    label: const Text('Foto zum Volk hinzufuegen'),
                  ),
                  const SizedBox(height: 12),
                  if (data.photos.isEmpty)
                    const Text('Noch keine Fotos zu diesem Volk.')
                  else
                    _PhotoAttachmentList(photos: data.photos),
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
                          onChanged: (_) {
                            debugPrint(
                              'HiveDetailScreen: checkbox changed for ${task.id}',
                            );
                            _completeTask(task.id);
                          },
                        ),
                        title: Text(task.title),
                        subtitle: Text(
                          '${task.categoryLabel} - fällig am '
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
    required this.photos,
    required this.latestInspectionPhotos,
  });

  final Hive hive;
  final BeeStand beeStand;
  final List<Inspection> inspections;
  final List<BeekeeperTask> openTasks;
  final List<PhotoAttachment> photos;
  final List<PhotoAttachment> latestInspectionPhotos;
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({
    required this.onCreateTask,
    required this.onEditHive,
    required this.onCreateInspection,
    required this.onOpenHistory,
    required this.onOpenLatestInspection,
  });

  final VoidCallback onCreateTask;
  final VoidCallback onEditHive;
  final VoidCallback onCreateInspection;
  final VoidCallback onOpenHistory;
  final VoidCallback? onOpenLatestInspection;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 560;
        final actions = [
          FilledButton.icon(
            onPressed: onCreateInspection,
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
            onPressed: onOpenHistory,
            icon: const Icon(Icons.history),
            label: const Text('Kontrollhistorie'),
          ),
          if (onOpenLatestInspection != null)
            OutlinedButton.icon(
              onPressed: onOpenLatestInspection,
              icon: const Icon(Icons.open_in_new),
              label: const Text('Letzte Kontrolle öffnen'),
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

class _HiveHeader extends StatelessWidget {
  const _HiveHeader({
    required this.hive,
    required this.beeStand,
    required this.primaryPhoto,
  });

  final Hive hive;
  final BeeStand beeStand;
  final PhotoAttachment? primaryPhoto;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final photo = _HiveTitlePhoto(photo: primaryPhoto);
            final details = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hive.number,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text('${beeStand.name} - ${beeStand.location}'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text(hive.statusLabel)),
                    Chip(label: Text('Königin ${hive.queenYear}')),
                    Chip(label: Text(_queenColorLabel(hive.queenColor))),
                  ],
                ),
              ],
            );

            if (constraints.maxWidth < 560) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [details, const SizedBox(height: 12), photo],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: details),
                const SizedBox(width: 16),
                photo,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HiveTitlePhoto extends StatelessWidget {
  const _HiveTitlePhoto({required this.photo});

  final PhotoAttachment? photo;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    if (photo == null) {
      return Container(
        width: 160,
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined),
            SizedBox(height: 6),
            Text('Kein Foto'),
          ],
        ),
      );
    }

    return PhotoThumbnail(
      localPath: photo.localPath,
      filename: photo.filename,
      width: 160,
      height: 120,
      onTap: () => showPhotoPreviewDialog(
        context: context,
        localPath: photo.localPath,
        filename: photo.filename,
        title: 'Foto vom Volk',
      ),
    );
  }
}

class _InspectionSummary extends StatelessWidget {
  const _InspectionSummary({
    required this.inspection,
    required this.photos,
    required this.onEdit,
    required this.onOpenPhotos,
    required this.onDelete,
  });

  final Inspection inspection;
  final List<PhotoAttachment> photos;
  final VoidCallback onEdit;
  final VoidCallback onOpenPhotos;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                formatDateTime(inspection.date),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            IconButton.filledTonal(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
              tooltip: 'Kontrolle bearbeiten',
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
              color: colorScheme.error,
              tooltip: 'Kontrolle löschen',
            ),
          ],
        ),
        const SizedBox(height: 8),
        _DetailRow(label: 'Gemutszustand', value: inspection.mood),
        _DetailRow(
          label: 'Königin gesehen',
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
        _DetailRow(label: 'Auffälligkeiten', value: _findingsText(inspection)),
        _DetailRow(label: 'Notizen', value: inspection.notes),
        if (photos.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              PhotoThumbnail(
                localPath: photos.first.localPath,
                filename: photos.first.filename,
                width: 88,
                height: 66,
                onTap: onOpenPhotos,
              ),
              Text(
                photos.length == 1
                    ? '1 Kontrollfoto vorhanden'
                    : '${photos.length} Kontrollfotos vorhanden',
              ),
              OutlinedButton.icon(
                onPressed: onOpenPhotos,
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Kontrollfotos anzeigen'),
              ),
            ],
          ),
        ],
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

String _queenColorLabel(String value) {
  return switch (value) {
    'Weiss' => 'Weiß',
    'Gruen' => 'Grün',
    _ => value,
  };
}

class _PhotoAttachmentList extends StatelessWidget {
  const _PhotoAttachmentList({required this.photos});

  final List<PhotoAttachment> photos;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final photo in photos)
          PhotoThumbnail(
            localPath: photo.localPath,
            filename: photo.filename,
            width: 112,
            height: 84,
            onTap: () => showPhotoPreviewDialog(
              context: context,
              localPath: photo.localPath,
              filename: photo.filename,
              title: 'Foto vom Volk',
            ),
          ),
      ],
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
        child: Text('Für diese Ansicht wurde kein Volk ausgewählt.'),
      ),
    );
  }
}
