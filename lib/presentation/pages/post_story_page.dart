import 'dart:io';

import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/story_provider.dart';
import 'package:fleegram/presentation/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostStoryPage extends StatefulWidget {
  const PostStoryPage({super.key});

  @override
  State<PostStoryPage> createState() => _PostStoryPageState();
}

class _PostStoryPageState extends State<PostStoryPage> {
  final _descriptionController = TextEditingController();
  File? _imageFile;
  bool _isUploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final l10n = AppLocalizations.of(context)!;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 70);

    if (!mounted || pickedFile == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(toolbarTitle: l10n.cropImage, lockAspectRatio: true),
        IOSUiSettings(title: l10n.cropImage),
      ],
    );

    if (cropped == null) return;

    setState(() {
      _imageFile = File(cropped.path);
    });
  }

  Future<void> _uploadStory() async {
    final l10n = AppLocalizations.of(context)!;
    final description = _descriptionController.text.trim();

    if (_imageFile == null || description.isEmpty) {
      SnackbarHelper.show(
        context,
        l10n.imageAndDescriptionRequired,
        type: SnackbarType.info,
      );
      return;
    }

    final storyProvider = context.read<StoryProvider>();

    setState(() => _isUploading = true);

    try {
      await storyProvider.uploadStory(
        imageFile: _imageFile!,
        description: description,
      );

      await storyProvider.fetchInitialStories();

      if (!mounted) return;

      SnackbarHelper.show(
        context,
        l10n.uploadSuccess,
        type: SnackbarType.success,
      );

      context.go('/');
    } catch (e) {
      if (!mounted) return;

      SnackbarHelper.show(context, l10n.errorNetwork, type: SnackbarType.error);
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.postStoryTitle)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: Colors.grey.shade200,
              child: _imageFile != null
                  ? Image.file(_imageFile!, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        l10n.noImage,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: Text(l10n.camera),
                ),
                OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo),
                  label: Text(l10n.gallery),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: l10n.descriptionLabel,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
              ),
              onPressed: _isUploading ? null : _uploadStory,
              child: _isUploading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(l10n.uploadButton),
            ),
          ],
        ),
      ),
    );
  }
}
