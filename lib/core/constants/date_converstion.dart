import 'package:intl/intl.dart';

/// DateConversion
///
/// Helper class for all date formatting.
/// Using the `intl` package.
class DateConversion {
  /// Converts Date to "dd/MM/yyyy" string
  /// Example: 25/12/2025
  static String dateMonthYear(DateTime dateTime) {
    return DateFormat("dd/MM/yyyy").format(dateTime);
  }

  /// Parses string ("2025-12-25") to DateTime object
  static DateTime stringToDate(String dateString) {
    return DateTime.parse(dateString);
  }

  /// Takes ISO string -> Converts to formatted Date string
  static String isoStringToFormattedDate(String isoString) {
    DateTime dateTime = DateTime.parse(isoString);
    return DateFormat("dd/MM/yyyy").format(dateTime);
  }
}
