import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/bee_stand.dart';
import '../../core/models/hive.dart';
import '../../core/models/inspection.dart';
import '../../core/models/photo_attachment.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';
import '../../core/widgets/photo_preview.dart';
import 'inspection_create_screen.dart';

class InspectionDetailScreen extends StatefulWidget {
  const InspectionDetailScreen({super.key, required this.inspectionId});

  final String? inspectionId;

  @override
  State<InspectionDetailScreen> createState() => _InspectionDetailScreenState();
}

class _InspectionDetailScreenState extends State<InspectionDetailScreen>
    with AppDataListener<InspectionDetailScreen> {
  late Future<_InspectionDetailData> _future;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
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
    if (_isDeleting) {
      return;
    }
    _reload();
  }

  Future<_InspectionDetailData> _loadData() async {
    final inspectionId = widget.inspectionId;
    if (inspectionId == null) {
      throw StateError('Missing inspection id');
    }

    final repositories = AppRepositories.instance;
    final inspection = await repositories.inspections.getById(inspectionId);
    final hive = await repositories.hives.getById(inspection.hiveId);
    final apiary = await repositories.apiaries.getById(hive.beeStandId);
    final photos = await repositories.photos.getForInspection(inspection.id);

    return _InspectionDetailData(
      inspection: inspection,
      hive: hive,
      apiary: apiary,
      photos: photos,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inspectionId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kontrolle')),
        body: const Center(child: Text('Keine Kontrolle ausgewählt.')),
      );
    }

    return FutureBuilder<_InspectionDetailData>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Kontrolle')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!;
        final inspection = data.inspection;

        return Scaffold(
          appBar: AppBar(title: Text(formatDateTime(inspection.date))),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                data.hive.number,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text('${data.apiary.name} - ${data.apiary.location}'),
              const SizedBox(height: 20),
              _ActionGrid(
                onEdit: () => _openEditForm(inspection),
                onDelete: () => _confirmDelete(inspection),
              ),
              const SizedBox(height: 20),
              _SectionCard(
                title: 'Allgemein',
                children: [
                  _DetailRow(
                    label: 'Datum',
                    value: formatDateTime(inspection.date),
                  ),
                  _DetailRow(label: 'Volk', value: data.hive.number),
                  _DetailRow(label: 'Bienenstand', value: data.apiary.name),
                  _DetailRow(label: 'Gemütszustand', value: inspection.mood),
                ],
              ),
              _SectionCard(
                title: 'Königin und Brut',
                children: [
                  _DetailRow(
                    label: 'Königin gesehen',
                    value: _yesNo(inspection.queenSeen),
                  ),
                  _DetailRow(
                    label: 'Wabensitz',
                    value: inspection.combPosition,
                  ),
                  _DetailRow(
                    label: 'Weiselzellen',
                    value: _yesNo(inspection.queenCellsSeen),
                  ),
                  _DetailRow(
                    label: 'Schwarmzellen',
                    value: _yesNo(inspection.swarmCellsSeen),
                  ),
                  _DetailRow(
                    label: 'Nachschaffungszellen',
                    value: _yesNo(inspection.emergencyCellsSeen),
                  ),
                  _DetailRow(
                    label: 'Zellen entfernt',
                    value: _yesNo(inspection.cellsRemoved),
                  ),
                  _DetailRow(
                    label: 'Brutrahmen',
                    value: inspection.broodFrameCount.toString(),
                  ),
                  _DetailRow(
                    label: 'Königinnenfarbe',
                    value: _queenColorLabel(inspection.queenColor),
                  ),
                ],
              ),
              _SectionCard(
                title: 'Drohnenrahmen',
                children: [
                  _DetailRow(
                    label: 'Füllgrad',
                    value: inspection.droneFrameFillLevel,
                  ),
                  _DetailRow(
                    label: 'Entfernt',
                    value: _yesNo(inspection.droneFrameRemoved),
                  ),
                  _DetailRow(
                    label: 'Erneuert',
                    value: _yesNo(inspection.droneFrameRenewed),
                  ),
                ],
              ),
              _SectionCard(
                title: 'Volksstaerke und Futter',
                children: [
                  _DetailRow(
                    label: 'Volksstaerke',
                    value: '${inspection.colonyStrength}/10',
                  ),
                  _DetailRow(
                    label: 'Futterstatus',
                    value: inspection.feedStatus,
                  ),
                  _DetailRow(
                    label: 'Fütterung',
                    value: _yesNo(inspection.feedingDone),
                  ),
                  _DetailRow(label: 'Futterart', value: inspection.feedType),
                  _DetailRow(
                    label: 'Futtermenge',
                    value: inspection.feedAmount?.toString() ?? '-',
                  ),
                ],
              ),
              _SectionCard(
                title: 'Honigraum',
                children: [
                  _DetailRow(
                    label: 'Absperrgitter',
                    value: _yesNo(inspection.queenExcluderInserted),
                  ),
                  _DetailRow(
                    label: 'Honigräume',
                    value: inspection.honeySuperCount.toString(),
                  ),
                  _DetailRow(
                    label: 'Füllstand',
                    value: inspection.honeySuperFillLevel,
                  ),
                  _DetailRow(
                    label: 'Verdeckelung',
                    value: inspection.honeyCappingState,
                  ),
                  _DetailRow(
                    label: 'Wassergehalt',
                    value: inspection.honeyWaterContent == null
                        ? '-'
                        : '${inspection.honeyWaterContent} %',
                  ),
                  _DetailRow(
                    label: 'Bienenflucht',
                    value: _yesNo(inspection.beeEscapeInserted),
                  ),
                ],
              ),
              _SectionCard(
                title: 'Behandlung',
                children: [
                  _DetailRow(
                    label: 'Varroa',
                    value: _yesNo(inspection.varroaTreatmentDone),
                  ),
                  _DetailRow(
                    label: 'Mittel',
                    value: inspection.varroaTreatment,
                  ),
                ],
              ),
              _SectionCard(
                title: 'Notizen',
                children: [
                  Text(
                    inspection.notes.isEmpty
                        ? 'Keine Notizen hinterlegt.'
                        : inspection.notes,
                  ),
                ],
              ),
              _SectionCard(
                title: 'Fotos zur Kontrolle',
                children: [
                  if (data.photos.isEmpty)
                    const Text('Keine Fotos zu dieser Kontrolle.')
                  else
                    _PhotoAttachmentList(photos: data.photos),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openEditForm(Inspection inspection) async {
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

  Future<void> _confirmDelete(Inspection inspection) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kontrolle löschen?'),
          content: const Text(
            'Diese Kontrolle wird dauerhaft aus der lokalen Datenbank entfernt.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
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

    _isDeleting = true;
    await AppRepositories.instance.inspections.deleteInspection(inspection.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kontrolle wurde gelöscht.')));
    Navigator.pop(context, true);
  }

  String _yesNo(bool value) {
    return value ? 'Ja' : 'Nein';
  }
}

class _InspectionDetailData {
  const _InspectionDetailData({
    required this.inspection,
    required this.hive,
    required this.apiary,
    required this.photos,
  });

  final Inspection inspection;
  final Hive hive;
  final BeeStand apiary;
  final List<PhotoAttachment> photos;
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final actions = [
          FilledButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit),
            label: const Text('Bearbeiten'),
          ),
          OutlinedButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Loeschen'),
          ),
        ];

        if (constraints.maxWidth < 560) {
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
      margin: const EdgeInsets.only(bottom: 12),
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
              title: 'Kontrollfoto',
            ),
          ),
      ],
    );
  }
}
