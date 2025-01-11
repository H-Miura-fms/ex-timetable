class Utils {
  static Duration calcDuration(String start, String end) {
    final s = fromHHMM(start);
    final e = fromHHMM(end);
    return e.difference(s);
  }

  static DateTime fromHHMM(String hhmm) {
    final parts = hhmm.split(':');
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
    // return DateTime( int.parse(parts[0]), int.parse(parts[1]));
  }

  static toDataTime(String date) {
    return DateTime.parse(date);
  }

  static String toHHMM(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static bool isOnTime(String start, String end) {
    final now = DateTime.now();
    final s = fromHHMM(start);
    final e = fromHHMM(end);
    return s.isBefore(now) && e.isAfter(now);
  }
}
