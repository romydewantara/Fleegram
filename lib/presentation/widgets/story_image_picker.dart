import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fleegram/core/constants/app_assets.dart';
import 'package:fleegram/l10n/app_localization.dart';
import 'package:flutter/material.dart';

class StoryImagePicker extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;

  const StoryImagePicker({
    super.key,
    required this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: imageFile == null
          ? DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(16),
              dashPattern: const [8, 4],
              strokeWidth: 2,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).dividerColor,
              child: Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.icAddImage, width: 98),
                    const SizedBox(height: 8),
                    Text(
                      l10n.noImage,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: FileImage(imageFile!),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.photo_camera_back_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
