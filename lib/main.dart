import 'package:fleegram/app/fleegram_app.dart';
import 'package:fleegram/core/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager.loadSession();
  await initializeDateFormatting();

  runApp(const Fleegram());
}
