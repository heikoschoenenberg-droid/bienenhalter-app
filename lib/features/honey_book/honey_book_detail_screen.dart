import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/honey_book_entry.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';
import 'honey_book_form_screen.dart';

class HoneyBookDetailScreen extends StatefulWidget {
  const HoneyBookDetailScreen({super.key, required this.entryId});

  final String? entryId;

  @override
  State<HoneyBookDetailScreen> createState() => _HoneyBookDetailScreenState();
}

class _HoneyBookDetailScreenState extends State<HoneyBookDetailScreen>
    with AppDataListener<HoneyBookDetailScreen> {
  late Future<HoneyBookEntry> _future;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _future = _loadEntry();
  }

  @override
  void onAppDataChanged() {
    if (!_isDeleting) {
      _reload();
    }
  }

  Future<HoneyBookEntry> _loadEntry() {
    final entryId = widget.entryId;
    if (entryId == null) {
      throw StateError('Missing honey book entry id');
    }
    return AppRepositories.instance.honeyBook.getHoneyBookEntryById(entryId);
  }

  Future<void> _reload() async {
    if (!mounted) {
      return;
    }
    final future = _loadEntry();
    setState(() {
      _future = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entryId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Honigbuch')),
        body: const Center(child: Text('Kein Honigbuch-Eintrag ausgewählt.')),
      );
    }

    return FutureBuilder<HoneyBookEntry>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Honigbuch')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final entry = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: Text(entry.honeyType)),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                entry.runningNumber.isEmpty
                    ? entry.honeyType
                    : '${entry.runningNumber} - ${entry.honeyType}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              _ActionGrid(
                onEdit: () => _openEditForm(entry.id),
                onDelete: () => _confirmDelete(entry),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Schleudervorgang',
                children: [
                  _DetailRow(label: 'lfd. Nr.', value: entry.runningNumber),
                  _DetailRow(
                    label: 'Schleuderdatum',
                    value: formatDate(entry.harvestDate),
                  ),
                  _DetailRow(
                    label: 'Schleuderort',
                    value: entry.extractionLocation,
                  ),
                  _DetailRow(label: 'Honigsorte', value: entry.honeyType),
                  _DetailRow(label: 'Herkunft', value: entry.originNote),
                ],
              ),
              _SectionCard(
                title: 'Messwerte und Charge',
                children: [
                  _DetailRow(
                    label: 'Wassergehalt',
                    value: entry.waterContentPercent == null
                        ? '-'
                        : '${entry.waterContentPercent!.toStringAsFixed(1)} %',
                  ),
                  _DetailRow(
                    label: 'Menge',
                    value: '${entry.amountKg.toStringAsFixed(1)} kg',
                  ),
                  _DetailRow(
                    label: 'abgefüllt am',
                    value: entry.bottledAt == null
                        ? '-'
                        : formatDate(entry.bottledAt),
                  ),
                  _DetailRow(
                    label: 'Gewährstreifen von',
                    value: entry.labelNumberFrom,
                  ),
                  _DetailRow(
                    label: 'Gewährstreifen bis',
                    value: entry.labelNumberTo,
                  ),
                  _DetailRow(label: 'Losnummer', value: entry.batchNumber),
                  _DetailRow(
                    label: 'MHD',
                    value: entry.bestBeforeDate == null
                        ? '-'
                        : formatDate(entry.bestBeforeDate),
                  ),
                  _DetailRow(
                    label: 'Verarbeitung',
                    value: entry.processingType.label,
                  ),
                ],
              ),
              _SectionCard(
                title: 'Bemerkungen',
                children: [
                  Text(
                    entry.notes.isEmpty
                        ? 'Keine Bemerkungen hinterlegt.'
                        : entry.notes,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openEditForm(String entryId) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.honeyBookForm,
      arguments: HoneyBookFormArguments(entryId: entryId),
    );
    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _confirmDelete(HoneyBookEntry entry) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Honigbuch-Eintrag löschen?'),
          content: const Text(
            'Möchtest du diesen Honigbuch-Eintrag wirklich löschen?',
          ),
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

    _isDeleting = true;
    await AppRepositories.instance.honeyBook.deleteHoneyBookEntry(entry.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Honigbuch-Eintrag wurde gelöscht.')),
    );
    Navigator.pop(context, true);
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid({required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
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
      ],
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
      margin: const EdgeInsets.only(bottom: 16),
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
            width: 190,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }
}
