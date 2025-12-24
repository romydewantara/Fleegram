import 'package:flutter/material.dart';

enum SnackbarType { success, error, info }

class SnackbarHelper {
  static void show(
    BuildContext context,
    String message, {
    SnackbarType type = SnackbarType.info,
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

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Expanded(child: Text(message)),
            ],
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
