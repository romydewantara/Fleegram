import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../../core/utils/session_manager.dart';
import '../models/story_model.dart';

class StoryRepository {
  final http.Client client;

  StoryRepository({http.Client? client}) : client = client ?? http.Client();

  Future<List<Story>> getStories({
    int page = 1,
    int size = 10,
    int location = 0,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}/stories'
      '?page=$page&size=$size&location=$location',
    );

    final response = await client.get(
      uri,
      headers: {'Authorization': 'Bearer ${SessionManager.token}'},
    );

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List list = json['listStory'];
      return list.map((e) => Story.fromJson(e)).toList();
    } else {
      throw Exception(json['message'] ?? 'Gagal memuat cerita');
    }
  }

  Future<void> uploadStory({
    required File imageFile,
    required String description,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}/stories'),
    );

    request.headers['Authorization'] = 'Bearer ${SessionManager.token}';

    request.fields['description'] = description;

    request.files.add(
      await http.MultipartFile.fromPath('photo', imageFile.path),
    );

    final response = await request.send();

    if (response.statusCode != 201) {
      throw Exception('Gagal mengunggah cerita');
    }
  }
}
