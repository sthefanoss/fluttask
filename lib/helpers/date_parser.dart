class DateTimeFormatter {
  static DateTime decode(String dateAsString) {
    try {
      final dateSlices = dateAsString.split('/');

      int year = int.parse(dateSlices[2]);
      int month = int.parse(dateSlices[1]);
      int day = int.parse(dateSlices[0]);

      DateTime date = DateTime(year, month, day);

      if (date.year != year || date.month != month || date.day != day)
        return null;

      return date;
    } catch (_) {
      return null;
    }
  }

  static String encode(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
