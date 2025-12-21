import 'dart:convert';

import 'package:fleegram/core/constants/api_constants.dart';
import 'package:fleegram/core/utils/session_manager.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    bool withAuth = false,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConstants.baseUrl}$path'),
      headers: _headers(withAuth),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
    bool withAuth = false,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}$path',
    ).replace(queryParameters: query);

    final response = await _client.get(uri, headers: _headers(withAuth));

    return _handleResponse(response);
  }

  Map<String, String> _headers(bool withAuth) {
    return {
      'Content-Type': 'application/json',
      if (withAuth && SessionManager.token != null)
        'Authorization': 'Bearer ${SessionManager.token}',
    };
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json;
    }

    throw ApiException(_mapErrorCode(json), statusCode: response.statusCode);
  }

  ApiErrorCode _mapErrorCode(Map<String, dynamic> json) {
    final message = json['message'];

    switch (message) {
      case '"email" must be a valid email':
        return ApiErrorCode.mustValidEmail;
      case 'Email is already taken':
        return ApiErrorCode.emailAlreadyTaken;
      case 'User not found':
        return ApiErrorCode.userNotFound;
      case 'Invalid password':
        return ApiErrorCode.invalidPassword;
      default:
        return ApiErrorCode.unknown;
    }
  }
}
