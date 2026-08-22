import 'package:intl/intl.dart';

class TimeFormatUtil {
  /// Convert milliseconds since epoch to local time string
  /// [milliseconds] - epoch milliseconds
  /// [format] - optional custom format (default: 'hh:mm a')
  static String formatTime(int milliseconds, {String format = 'hh:mm a'}) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final local = dateTime.toLocal();
    return DateFormat(format).format(local);
  }

  /// Format full date and time (e.g., "Aug 20, 2024 12:50 PM")
  static String formatDateTime(int milliseconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final local = dateTime.toLocal();
    return DateFormat('MMM dd, yyyy hh:mm a').format(local);
  }

  /// Format time only in 12-hour format (e.g., "12:50 PM")
  static String formatTime12Hour(int milliseconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final local = dateTime.toLocal();
    return DateFormat('hh:mm a').format(local);
  }

  /// Format time only in 24-hour format (e.g., "12:50")
  static String formatTime24Hour(int milliseconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final local = dateTime.toLocal();
    return DateFormat('HH:mm').format(local);
  }

  /// Format date only (e.g., "Aug 20, 2024")
  static String formatDate(int milliseconds) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final local = dateTime.toLocal();
    return DateFormat('MMM dd, yyyy').format(local);
  }

  /// Format appointment slot range (e.g., "12:50 PM - 1:50 PM")
  static String formatSlotRange(int startMs, int endMs) {
    final startTime = formatTime12Hour(startMs);
    final endTime = formatTime12Hour(endMs);
    return '$startTime - $endTime';
  }

  /// Format appointment slot with date (e.g., "Aug 20 | 12:50 PM - 1:50 PM")
  static String formatSlotWithDate(int startMs, int endMs) {
    final date = formatDate(startMs);
    final timeRange = formatSlotRange(startMs, endMs);
    return '$date | $timeRange';
  }

  /// Get time difference in hours/minutes
  static String formatDuration(int startMs, int endMs) {
    final duration = Duration(milliseconds: endMs - startMs);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '$hours h ${minutes}m';
    }
    return '${minutes}m';
  }

  /// Convert DateTime object to local time (helper)
  static DateTime toLocalTime(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds).toLocal();
  }

  /// Check if time is today
  static bool isToday(int milliseconds) {
    final dateTime = toLocalTime(milliseconds);
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if time is tomorrow
  static bool isTomorrow(int milliseconds) {
    final dateTime = toLocalTime(milliseconds);
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return dateTime.year == tomorrow.year &&
        dateTime.month == tomorrow.month &&
        dateTime.day == tomorrow.day;
  }

  /// Format with "Today/Tomorrow" prefix if applicable
  /// Example: "Today at 12:50 PM" or "Tomorrow at 3:00 PM"
  static String formatTimeWithDay(int milliseconds) {
    final timeStr = formatTime12Hour(milliseconds);

    if (isToday(milliseconds)) {
      return 'Today at $timeStr';
    } else if (isTomorrow(milliseconds)) {
      return 'Tomorrow at $timeStr';
    } else {
      return formatDateTime(milliseconds);
    }
  }
}
