import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class SnackbarHelper {
  static SnackbarType? _currentType;
  static ScaffoldMessengerState? _messenger;

  static void attach(ScaffoldMessengerState messenger) {
    _messenger = messenger;
  }

  static void show(
    BuildContext context,
    String message, {
    SnackbarType type = SnackbarType.info,
    double marginVertical = 16,
    double marginHorizontal = 16,
  }) {
    late IconData icon;
    late Color color;

    switch (type) {
      case SnackbarType.success:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case SnackbarType.error:
        icon = Icons.warning;
        color = Colors.red;
        break;
      case SnackbarType.info:
        icon = Icons.info;
        color = Colors.blue;
    }

    final messenger = ScaffoldMessenger.of(context);
    _messenger ??= messenger;
    _currentType = type;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(
            vertical: marginVertical,
            horizontal: marginHorizontal,
          ),
          content: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }

  static void clearIfNotSuccess() {
    if (_currentType != SnackbarType.success) {
      _messenger?.clearSnackBars();
    }
  }
}
