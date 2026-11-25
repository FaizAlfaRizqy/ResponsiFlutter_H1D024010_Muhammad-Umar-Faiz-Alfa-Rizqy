import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatHeroDateTime(DateTime dateTime) {
    // Format: "Tue, Nov 24 · 7:41 PM"
    final weekdayMonthDay = DateFormat('EEE, MMM d').format(dateTime);
    final time = DateFormat('h:mm a').format(dateTime);
    return '$weekdayMonthDay · $time';
  }

  static String formatLastUpdated(DateTime dateTime) {
    // Format: "Last updated 7:40 PM · Open-Meteo"
    final time = DateFormat('h:mm a').format(dateTime);
    return 'Last updated $time · Open-Meteo';
  }

  static String getDayOfWeek(String isoDateString) {
    try {
      final date = DateTime.parse(isoDateString);
      return DateFormat('EEE').format(date);
    } catch (_) {
      return '';
    }
  }

  static String getMonthDay(String isoDateString) {
    try {
      final date = DateTime.parse(isoDateString);
      return DateFormat('MMM d').format(date);
    } catch (_) {
      return '';
    }
  }
}
