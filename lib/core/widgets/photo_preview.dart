import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'photo_preview_stub.dart'
    if (dart.library.io) 'photo_preview_io.dart'
    as platform;

class PhotoPreview extends StatelessWidget {
  const PhotoPreview({
    super.key,
    required this.localPath,
    required this.filename,
    this.width,
    this.height = 96,
    this.fit = BoxFit.cover,
    this.borderRadius = 8,
  });

  final String localPath;
  final String filename;
  final double? width;
  final double height;
  final BoxFit fit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: platform.buildPhotoPreview(
        context: context,
        localPath: localPath,
        filename: filename,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}

class PhotoThumbnail extends StatelessWidget {
  const PhotoThumbnail({
    super.key,
    required this.localPath,
    required this.filename,
    this.width = 96,
    this.height = 72,
    this.onTap,
  });

  final String localPath;
  final String filename;
  final double width;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final thumbnail = SizedBox(
      width: width,
      height: height,
      child: PhotoPreview(
        localPath: localPath,
        filename: filename,
        width: width,
        height: height,
      ),
    );

    if (onTap == null) {
      return thumbnail;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: thumbnail,
    );
  }
}

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({
    super.key,
    required this.photos,
    this.thumbnailWidth = 112,
    this.thumbnailHeight = 84,
  });

  final Iterable<({String localPath, String filename})> photos;
  final double thumbnailWidth;
  final double thumbnailHeight;

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
            width: thumbnailWidth,
            height: thumbnailHeight,
            onTap: () => showPhotoPreviewDialog(
              context: context,
              localPath: photo.localPath,
              filename: photo.filename,
            ),
          ),
      ],
    );
  }
}

Future<void> showPhotoPreviewDialog({
  required BuildContext context,
  required String localPath,
  required String filename,
  String title = 'Foto',
}) {
  final size = MediaQuery.sizeOf(context);
  final dialogWidth = math.max(280.0, math.min(size.width - 48, 760.0));
  final imageHeight = math.max(220.0, math.min(size.height - 220, 520.0));

  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: SizedBox(
            width: dialogWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PhotoPreview(
                  localPath: localPath,
                  filename: filename,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.contain,
                  borderRadius: 10,
                ),
                const SizedBox(height: 12),
                Text(filename, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Schliessen'),
          ),
        ],
      );
    },
  );
}
