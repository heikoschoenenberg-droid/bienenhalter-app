import 'dart:io';

import 'package:flutter/material.dart';

Widget buildPhotoPreview({
  required BuildContext context,
  required String localPath,
  required String filename,
  required double? width,
  required double height,
  required BoxFit fit,
}) {
  return Image.file(
    File(localPath),
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return _fallback(context, filename, width, height);
    },
  );
}

Widget _fallback(
  BuildContext context,
  String filename,
  double? width,
  double height,
) {
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
        const Icon(Icons.image_not_supported_outlined),
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
