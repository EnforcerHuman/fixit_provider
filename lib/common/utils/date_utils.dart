import 'package:intl/intl.dart';

class DateUtil {
  String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  DateTime parseTime(String time) {
    // final now = DateTime.now();
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return DateTime(hour, minute);
  }
}
