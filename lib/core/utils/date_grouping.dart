import 'package:intl/intl.dart';

class DateGrouping {
  static String label(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final yesterday = today.subtract(const Duration(days: 1));

    final target = DateTime(date.year, date.month, date.day);

    if (target == today) return 'Today';

    if (target == yesterday) return 'Yesterday';

    return DateFormat('MMMM d, yyyy').format(date);
  }
}
