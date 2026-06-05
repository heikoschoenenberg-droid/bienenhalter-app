import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/hive.dart';
import '../../core/models/stock_card_photo_import.dart';
import '../../core/services/app_repositories.dart';
import '../../core/services/stock_card_import_service.dart';
import '../inspections/inspection_create_screen.dart';

class StockCardImportScreen extends StatefulWidget {
  const StockCardImportScreen({super.key});

  @override
  State<StockCardImportScreen> createState() => _StockCardImportScreenState();
}

class _StockCardImportScreenState extends State<StockCardImportScreen> {
  final _importService = StockCardImportService.instance;
  late Future<List<Hive>> _hivesFuture;

  @override
  void initState() {
    super.initState();
    _hivesFuture = AppRepositories.instance.hives.getAll();
  }

  Future<void> _pickPhotos() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    _importService.addImports(
      result.files.map(
        (file) => (filename: file.name, path: file.path, bytes: file.bytes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stockkarten auswerten')),
      body: FutureBuilder<List<Hive>>(
        future: _hivesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final hives = snapshot.data!;
          return ValueListenableBuilder<List<StockCardPhotoImport>>(
            valueListenable: _importService.imports,
            builder: (context, imports, _) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Stockkarten auswerten',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Waehle Fotos deiner Stockkarten aus. Die automatische '
                    'Auswertung wird spaeter ergaenzt. Aktuell kannst du '
                    'Bilder sammeln, einem Volk zuordnen und als '
                    'Kontrollvorschlag vorbereiten.',
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: _pickPhotos,
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                    label: const Text('Fotos auswaehlen'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Import-Stapel',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  if (imports.isEmpty)
                    const _EmptyImportState()
                  else
                    for (final item in imports) ...[
                      _StockCardImportCard(
                        item: item,
                        hives: hives,
                        onAssignHive: (hiveId) {
                          _importService.assignHive(
                            importId: item.id,
                            hiveId: hiveId,
                          );
                        },
                        onRemove: () => _importService.removeImport(item.id),
                        onCreateDraft: () {
                          _showDraftDialog(item);
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showDraftDialog(StockCardPhotoImport item) async {
    final hiveId = item.hiveId;
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kontrollvorschlag erstellen'),
          content: Text(
            hiveId == null
                ? 'Bitte zuerst ein Volk zuordnen.'
                : 'Die automatische Erkennung wird spaeter ergaenzt. Fuer '
                      'dieses Foto kann aktuell ein manueller '
                      'Kontrollentwurf erstellt werden.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Schliessen'),
            ),
            if (hiveId != null)
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.inspectionCreate,
                    arguments: InspectionFormArguments(
                      hiveId: hiveId,
                      sourcePhotoImportId: item.id,
                    ),
                  );
                },
                child: const Text('Manuelle Kontrolle oeffnen'),
              ),
          ],
        );
      },
    );
  }
}

class _EmptyImportState extends StatelessWidget {
  const _EmptyImportState();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.photo_library_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 8),
            const Text('Noch keine Fotos im Import-Stapel.'),
          ],
        ),
      ),
    );
  }
}

class _StockCardImportCard extends StatelessWidget {
  const _StockCardImportCard({
    required this.item,
    required this.hives,
    required this.onAssignHive,
    required this.onRemove,
    required this.onCreateDraft,
  });

  final StockCardPhotoImport item;
  final List<Hive> hives;
  final ValueChanged<String?> onAssignHive;
  final VoidCallback onRemove;
  final VoidCallback onCreateDraft;

  @override
  Widget build(BuildContext context) {
    final assignedHive = item.hiveId == null
        ? null
        : hives.where((hive) => hive.id == item.hiveId).firstOrNull;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PhotoPreview(item: item),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.filename,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(item.path ?? _byteInfo(item)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(label: Text(item.statusLabel)),
                          Chip(label: Text(formatDateTime(item.createdAt))),
                          if (assignedHive != null)
                            Chip(label: Text('Volk: ${assignedHive.number}')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('stock-card-${item.id}-${item.hiveId ?? 'none'}'),
              initialValue: item.hiveId,
              decoration: const InputDecoration(
                labelText: 'Volk zuordnen',
                border: OutlineInputBorder(),
              ),
              items: [
                for (final hive in hives)
                  DropdownMenuItem(value: hive.id, child: Text(hive.number)),
              ],
              onChanged: onAssignHive,
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final actions = [
                  OutlinedButton.icon(
                    onPressed: onCreateDraft,
                    icon: const Icon(Icons.fact_check_outlined),
                    label: const Text('Kontrollvorschlag erstellen'),
                  ),
                  OutlinedButton.icon(
                    onPressed: onRemove,
                    icon: const Icon(Icons.close),
                    label: const Text('Entfernen'),
                  ),
                ];

                if (constraints.maxWidth < 560) {
                  return Column(
                    children: [
                      for (final action in actions) ...[
                        SizedBox(width: double.infinity, child: action),
                        if (action != actions.last) const SizedBox(height: 8),
                      ],
                    ],
                  );
                }

                return Row(
                  children: [
                    for (final action in actions) ...[
                      Expanded(child: action),
                      if (action != actions.last) const SizedBox(width: 8),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _byteInfo(StockCardPhotoImport item) {
    final bytes = item.bytes;
    if (bytes == null) {
      return 'Keine Pfadinformation verfuegbar';
    }
    return '${bytes.lengthInBytes} Bytes im Speicher';
  }
}

class _PhotoPreview extends StatelessWidget {
  const _PhotoPreview({required this.item});

  final StockCardPhotoImport item;

  @override
  Widget build(BuildContext context) {
    final bytes = item.bytes;
    if (bytes == null) {
      return Container(
        width: 96,
        height: 96,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image_not_supported_outlined),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(bytes, width: 96, height: 96, fit: BoxFit.cover),
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      return iterator.current;
    }
    return null;
  }
}
