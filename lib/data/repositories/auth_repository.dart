import 'package:fleegram/core/network/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<String> login(String email, String password) async {
    final json = await apiClient.post(
      '/login',
      body: {'email': email, 'password': password},
    );

    return json['loginResult']['token'];
  }

  Future<void> register(String name, String email, String password) async {
    await apiClient.post(
      '/register',
      body: {'name': name, 'email': email, 'password': password},
    );
  }
}
