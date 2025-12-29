import 'dart:io';

import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/story_provider.dart';
import 'package:fleegram/presentation/utils/snackbar_helper.dart';
import 'package:fleegram/presentation/widgets/story_image_picker.dart';
import 'package:fleegram/presentation/widgets/story_image_source_bottom_sheet.dart';
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
  final FocusNode _descFocusNode = FocusNode();
  final _descriptionController = TextEditingController();

  File? _imageFile;
  bool _isUploading = false;
  bool _isPickingImage = false;

  @override
  void dispose() {
    _descFocusNode.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final l10n = AppLocalizations.of(context)!;
    final picker = ImagePicker();

    setState(() => _isPickingImage = true);

    try {
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (!mounted || pickedFile == null) {
        setState(() => _isPickingImage = false);
        return;
      }

      final cropped = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: l10n.cropImage,
            lockAspectRatio: true,
          ),
          IOSUiSettings(title: l10n.cropImage),
        ],
      );

      if (cropped == null) {
        setState(() => _isPickingImage = false);
        return;
      }

      setState(() {
        _imageFile = File(cropped.path);
        _isPickingImage = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() => _isPickingImage = false);
      }
    }
  }

  Future<void> _uploadStory() async {
    final l10n = AppLocalizations.of(context)!;
    final description = _descriptionController.text.trim();

    if (_imageFile == null || description.isEmpty) {
      SnackbarHelper.show(
        context,
        l10n.imageAndDescriptionRequired,
        type: SnackbarType.info,
        marginVertical: 80,
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
    } catch (_) {
      if (!mounted) return;
      SnackbarHelper.show(
        context,
        l10n.errorNetwork,
        type: SnackbarType.error,
        marginVertical: 90,
      );
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(l10n.postStoryTitle),
              centerTitle: false,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StoryImagePicker(
                      imageFile: _imageFile,
                      onTap: () {
                        StoryImageSourceBottomSheet.show(
                          context: context,
                          l10n: l10n,
                          theme: theme,
                          onPick: _pickImage,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _descriptionController,
                      focusNode: _descFocusNode,
                      maxLines: 5,
                      style: theme.textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: l10n.descriptionLabel,
                        hintStyle: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.hintColor,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _isUploading ? null : _uploadStory,
              child: _isUploading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      l10n.uploadButton,
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
          ),
          if (_isPickingImage)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
