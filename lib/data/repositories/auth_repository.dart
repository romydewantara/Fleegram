import 'package:fleegram/core/network/api_client.dart';
import 'package:fleegram/data/models/login_response.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<LoginResult> login(String email, String password) async {
    final json = await apiClient.post(
      '/login',
      body: {'email': email, 'password': password},
    );

    final result = LoginResponse.fromJson(json);
    return result.loginResult;
  }

  Future<void> register(String name, String email, String password) async {
    await apiClient.post(
      '/register',
      body: {'name': name, 'email': email, 'password': password},
    );
  }
}
