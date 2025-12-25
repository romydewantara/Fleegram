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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
      if (!keyboardOpen && _descFocusNode.hasFocus) {
        _descFocusNode.unfocus();
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: Text(l10n.postStoryTitle), centerTitle: true),
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.all(16),
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
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _showImageSourceSheet,
                            child: Container(
                              height: 280,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16),
                                image: _imageFile != null
                                    ? DecorationImage(
                                        image: FileImage(_imageFile!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _imageFile == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add_photo_alternate_rounded,
                                          size: 48,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          l10n.noImage,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black54,
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 24),
                          TextField(
                            controller: _descriptionController,
                            focusNode: _descFocusNode,
                            maxLines: 5,
                            style: Theme.of(context).textTheme.bodyLarge,
                            decoration: InputDecoration(
                              hintText: l10n.descriptionLabel,
                              hintStyle: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isPickingImage)
            Positioned.fill(
              child: AbsorbPointer(
                absorbing: true,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showImageSourceSheet() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(l10n.gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(l10n.camera),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
