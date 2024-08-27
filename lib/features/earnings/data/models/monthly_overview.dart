class MonthlyOverview {
  final String monthYear;
  final String totalBookings;
  final String totalEarnings;

  MonthlyOverview(this.monthYear, this.totalBookings, this.totalEarnings);

  @override
  String toString() {
    return 'MonthlyOverview(monthYear: $monthYear, totalBookings: $totalBookings, totalEarnings: $totalEarnings)';
  }
}
