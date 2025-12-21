import 'dart:io';

import 'package:fleegram/core/constants/api_constants.dart';
import 'package:fleegram/core/utils/session_manager.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';

class MultipartClient {
  Future<void> postImage({
    required String path,
    required File imageFile,
    required Map<String, String> fields,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiConstants.baseUrl}$path'),
    );

    if (SessionManager.token != null) {
      request.headers['Authorization'] = 'Bearer ${SessionManager.token}';
    }

    request.fields.addAll(fields);

    request.files.add(
      await http.MultipartFile.fromPath('photo', imageFile.path),
    );

    final response = await request.send();

    if (response.statusCode != 201) {
      throw ApiException(ApiErrorCode.unknown, statusCode: response.statusCode);
    }
  }
}
