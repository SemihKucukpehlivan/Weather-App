import 'package:intl/intl.dart';

class FormatDate {
  FormatDate(DateTime date);

  static String formatDayAndMonth(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    return '$day-$month';
  }

  static formatWeekday(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}
