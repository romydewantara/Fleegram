import 'package:fleegram/core/network/api_exception.dart';
import 'package:fleegram/core/utils/session_manager.dart';
import 'package:fleegram/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider(this.authRepository);

  bool _isLoading = false;
  ApiErrorCode? _errorCode;

  bool get isLoading => _isLoading;
  ApiErrorCode? get errorCode => _errorCode;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    clearError();

    try {
      final token = await authRepository.login(email, password);

      await SessionManager.saveToken(token);
    } on ApiException catch (e) {
      _errorCode = e.code;
    } catch (e) {
      _errorCode = ApiErrorCode.errorNetwork;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String name, String email, String password) async {
    _setLoading(true);
    clearError();

    try {
      await authRepository.register(name, email, password);
    } on ApiException catch (e) {
      _errorCode = e.code;
    } catch (e) {
      _errorCode = ApiErrorCode.errorNetwork;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await SessionManager.clearSession();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearError() {
    _errorCode = null;
  }
}
