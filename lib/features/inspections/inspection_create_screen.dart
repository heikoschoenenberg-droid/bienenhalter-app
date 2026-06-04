import 'package:flutter/material.dart';

import '../../core/demo/demo_data.dart';

class InspectionCreateScreen extends StatelessWidget {
  const InspectionCreateScreen({super.key, required this.hiveId});

  final String? hiveId;

  @override
  Widget build(BuildContext context) {
    final hive = hiveId == null ? null : DemoData.hiveById(hiveId!);

    return Scaffold(
      appBar: AppBar(title: const Text('Kontrolle erfassen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hive == null ? 'Neuer Kontrollvorschlag' : hive.number,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.edit_note,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Platzhalter für Stockkontrollen',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Hier wird später eine Kontrolle manuell erfasst oder '
                      'aus einem Foto der physischen Stockkarte vorgeschlagen.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
