import 'package:intl/intl.dart';

class DateFormatter {
  static String formatIndo(DateTime date) {
    return DateFormat('MMMM d, yyyy', 'id_ID').format(date);
  }
}
