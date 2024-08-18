class IncomeData {
  final DateTime date;
  final double amount;

  IncomeData({required this.date, required this.amount});

  @override
  String toString() {
    // Format the DateTime object to a readable format, e.g., 'YYYY-MM-DD'
    String formattedDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    // Return the string representation of the IncomeData object
    return 'IncomeData(date: $formattedDate, amount: $amount)';
  }
}
