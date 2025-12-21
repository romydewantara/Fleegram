import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  static String formatFull(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toString();

    return DateFormat('MMMM d, yyyy', locale).format(date);
  }
}
