import 'dart:io';

import 'package:fleegram/core/network/api_client.dart';
import 'package:fleegram/core/network/multipart_client.dart';
import 'package:fleegram/data/models/story_model.dart';

class StoryRepository {
  final ApiClient apiClient;
  final MultipartClient multipartClient;

  StoryRepository({required this.apiClient, required this.multipartClient});

  Future<List<Story>> getStories({
    int page = 1,
    int size = 10,
    int location = 0,
  }) async {
    final json = await apiClient.get(
      '/stories',
      query: {'page': '$page', 'size': '$size', 'location': '$location'},
      withAuth: true,
    );

    return (json['listStory'] as List).map((e) => Story.fromJson(e)).toList();
  }

  Future<void> uploadStory({
    required File imageFile,
    required String description,
  }) async {
    await multipartClient.postImage(
      path: '/stories',
      imageFile: imageFile,
      fields: {'description': description},
    );
  }
}
