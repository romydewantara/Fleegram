import 'dart:io';

import 'package:fleegram/presentation/providers/story_provider.dart';
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 70);

    if (pickedFile == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      uiSettings: [
        AndroidUiSettings(toolbarTitle: 'Crop Gambar', lockAspectRatio: true),
        IOSUiSettings(title: 'Crop Gambar'),
      ],
    );

    if (cropped == null) return;

    setState(() {
      _imageFile = File(cropped.path);
    });
  }

  /*Future<void> _uploadStory() async {
    if (_imageFile == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gambar dan deskripsi wajib diisi')),
      );
      return;
    }

    final storyProvider = context.read<StoryProvider>();
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _isUploading = true);

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.baseUrl}/stories'),
      );

      request.headers['Authorization'] = 'Bearer ${SessionManager.token}';

      request.fields['description'] = _descriptionController.text.trim();

      request.files.add(
        await http.MultipartFile.fromPath('photo', _imageFile!.path),
      );

      final response = await request.send();

      if (response.statusCode == 201) {
        await storyProvider.fetchInitialStories();

        if (mounted) context.go('/');
      } else {
        throw Exception('Gagal mengunggah cerita');
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }*/

  Future<void> _uploadStory() async {
    if (_imageFile == null || _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gambar dan deskripsi wajib diisi')),
      );
      return;
    }

    final storyProvider = context.read<StoryProvider>();
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _isUploading = true);

    try {
      await storyProvider.uploadStory(
        imageFile: _imageFile!,
        description: _descriptionController.text.trim(),
      );

      await storyProvider.fetchInitialStories();

      if (!mounted) return;
      context.go('/');
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (!mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Cerita')),
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
                  : const Center(child: Text('Belum ada gambar')),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Kamera'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo),
                  label: const Text('Galeri'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
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
                  : const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
