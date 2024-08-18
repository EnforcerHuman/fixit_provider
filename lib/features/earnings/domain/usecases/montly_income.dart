import 'package:fixit_provider/features/earnings/domain/enitities/income.dart';
import 'package:fl_chart/fl_chart.dart';

class MontlyIncomeUseCase {
  Stream<List<FlSpot>> getMonthlyIncomeData() async* {
    // Replace with your actual implementation to fetch data
    List<IncomeData> incomeDataList = await fetchIncomeData();

    Map<DateTime, double> earningsByMonth = {};
    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);

    // Aggregate income by month
    for (var data in incomeDataList) {
      DateTime monthKey = DateTime(data.date.year, data.date.month);
      if (earningsByMonth.containsKey(monthKey)) {
        earningsByMonth[monthKey] = earningsByMonth[monthKey]! + data.amount;
      } else {
        earningsByMonth[monthKey] = data.amount;
      }
    }

    // Ensure all months of the current year are included
    List<DateTime> allMonths = List.generate(12, (index) {
      return DateTime(now.year, index + 1);
    });

    List<FlSpot> dataPoints = allMonths.map((month) {
      double amount = earningsByMonth[month] ?? 0.0;
      return FlSpot(month.month.toDouble() - 1, amount);
    }).toList();

    yield dataPoints;
  }

// Simulated fetch function, replace with your actual data fetching logic
  Future<List<IncomeData>> fetchIncomeData() async {
    // Dummy data for testing
    return [
      IncomeData(date: DateTime(2024, 1, 15), amount: 150.0),
      // IncomeData(date: DateTime(2024, 2, 22), amount: 200.0),
      // IncomeData(date: DateTime(2024, 3, 10), amount: 300.0),
      // IncomeData(date: DateTime(2024, 5, 5), amount: 250.0),
      // IncomeData(date: DateTime(2024, 7, 8), amount: 400.0),
    ];
  }
}
