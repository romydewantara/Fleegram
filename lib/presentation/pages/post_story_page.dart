import 'dart:io';

import 'package:fleegram/core/config/app_config.dart';
import 'package:fleegram/core/constants/app_assets.dart';
import 'package:fleegram/core/utils/session_manager.dart';
import 'package:fleegram/l10n/app_localization.dart';
import 'package:fleegram/presentation/providers/story_provider.dart';
import 'package:fleegram/presentation/utils/snackbar_helper.dart';
import 'package:fleegram/presentation/widgets/map_picker_sheet.dart';
import 'package:fleegram/presentation/widgets/premium_locked_tile.dart';
import 'package:fleegram/presentation/widgets/pulse_badge.dart';
import 'package:fleegram/presentation/widgets/story_image_picker.dart';
import 'package:fleegram/presentation/widgets/story_image_source_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  LatLng? _selectedLatLng;
  String? _selectedAddress;
  bool _isUploading = false;
  bool _isPickingImage = false;
  bool _isPickingLocation = false;

  @override
  void dispose() {
    SnackbarHelper.clearIfNotSuccess();
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
        lat: _selectedLatLng?.latitude,
        lon: _selectedLatLng?.longitude,
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
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurfaceVariant,
                            width: 1,
                          ),
                        ),
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: 2),
                    _buildPremiumLockedTile(theme, l10n),
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
          if (_isPickingImage || _isPickingLocation)
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

  Widget _buildPremiumLockedTile(ThemeData theme, AppLocalizations l10n) {
    final bool isPaid = context.read<AppConfig>().isPaid;

    return PremiumLockedTile(
      isPaid: isPaid,
      foreground: !isPaid
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.6)),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(6),
                onTap: () async {
                  final result = await context.push<bool>('/paid-info');

                  if (result == true && mounted) {
                    SnackbarHelper.show(
                      context,
                      l10n.contactAdminMessage(
                        SessionManager.name ?? l10n.userCalled,
                      ),
                      type: SnackbarType.info,
                      marginVertical: 80,
                    );
                  }
                },
                child: PulseBadge(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppAssets.icStar, width: 16, height: 16),
                        const SizedBox(width: 4),
                        Text(
                          l10n.paidLabel,
                          style: TextStyle(
                            color: Color(0xFF8D6E00),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        onTap: isPaid ? _openMapSheet : null,
        leading: Icon(
          Icons.location_on_outlined,
          color: theme.colorScheme.onSurface,
        ),
        title: Text(
          _selectedAddress ?? l10n.addLocation,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        trailing: _selectedAddress != null
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                onPressed: () {
                  setState(() {
                    _selectedAddress = null;
                    _selectedLatLng = null;
                  });
                },
              )
            : isPaid
            ? Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              )
            : null,
      ),
    );
  }

  void _openMapSheet() {
    setState(() {
      _isPickingLocation = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MapPickerSheet(
        initialLatLng: _selectedLatLng,
        onLocationPicked: (latLng, address) {
          setState(() {
            _selectedLatLng = latLng;
            _selectedAddress = address;
          });
        },
      ),
    ).whenComplete(() {
      if (mounted) {
        setState(() => _isPickingLocation = false);
      }
    });
  }
}
