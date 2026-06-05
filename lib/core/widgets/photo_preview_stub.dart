import 'package:flutter/material.dart';

Widget buildPhotoPreview({
  required BuildContext context,
  required String localPath,
  required String filename,
  required double? width,
  required double height,
  required BoxFit fit,
}) {
  final compact = height < 80 || (width != null && width < 90);

  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    color: Theme.of(context).colorScheme.surfaceContainerHighest,
    padding: const EdgeInsets.all(12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.image_outlined),
        if (!compact) ...[
          const SizedBox(height: 6),
          Text(
            filename,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text('Vorschau nicht verfuegbar', textAlign: TextAlign.center),
        ],
      ],
    ),
  );
}
