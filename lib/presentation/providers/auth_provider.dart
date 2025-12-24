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
      final result = await authRepository.login(email, password);

      await SessionManager.saveToken(result.token);
      await SessionManager.saveUser(name: result.name, email: email);
    } on ApiException catch (e) {
      _errorCode = e.code;
    } catch (e) {
      _errorCode = ApiErrorCode.errorNetwork;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    clearError();

    try {
      await authRepository.register(name, email, password);
      return true;
    } on ApiException catch (e) {
      _errorCode = e.code;
      return false;
    } catch (e) {
      _errorCode = ApiErrorCode.errorNetwork;
      return false;
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
