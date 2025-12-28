import 'package:intl/intl.dart';

class DateFormatter {
  static String formatFull({
    required DateTime date,
    required String locale,
    required String pattern,
  }) {
    return DateFormat(pattern, locale).format(date);
  }
}
