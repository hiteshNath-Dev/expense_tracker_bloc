class Utils {
  static String dateFormated(String date) {
    DateTime parseDate = DateTime.parse(date);
    return '${parseDate.day}/${parseDate.month}/${parseDate.year}';
  }

  static String formatAmount(String amount) {
    try {
      final double value = double.parse(amount);
      return value.toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
  }
}
