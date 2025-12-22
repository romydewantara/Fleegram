import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const _tokenKey = 'auth_token';
  static const _nameKey = 'user_name';
  static const _emailKey = 'user_email';

  static String? _token;
  static String? _name;
  static String? _email;

  static String? get token => _token;
  static String? get name => _name;
  static String? get email => _email;

  static bool get isLoggedIn => _token != null;

  static Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    _name = prefs.getString(_nameKey);
    _email = prefs.getString(_emailKey);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    _token = token;
  }

  static Future<void> saveUser({
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);

    _name = name;
    _email = email;
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tokenKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_emailKey);

    _token = null;
    _name = null;
    _email = null;
  }
}
