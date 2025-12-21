import 'dart:convert';

import 'package:fleegram/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final http.Client client;

  AuthRepository({http.Client? client}) : client = client ?? http.Client();

  Future<String> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return json['loginResult']['token'];
    } else {
      throw Exception(json['message'] ?? 'Login failed, please try again');
    }
  }

  Future<void> register(String name, String email, String password) async {
    final response = await client.post(
      Uri.parse('${ApiConstants.baseUrl}/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    final Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode != 201) {
      throw Exception(json['message'] ?? 'Registration failed');
    }
  }
}
