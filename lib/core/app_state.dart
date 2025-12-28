import 'package:flutter/foundation.dart';
import 'utils/session_manager.dart';

class AppState extends ChangeNotifier {
  bool splashDone = false;

  Future<void> init() async {
    await SessionManager.loadSession();
    splashDone = false;
    notifyListeners();
  }

  void finishSplash() {
    splashDone = true;
    notifyListeners();
  }
}

final appState = AppState();
