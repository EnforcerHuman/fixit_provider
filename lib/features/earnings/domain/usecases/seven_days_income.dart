import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/earnings/data/earnings_booking_data_source.dart';
import 'package:fixit_provider/features/earnings/domain/enitities/income.dart';

class GetLast7DaysIncomeUseCase {
  final EarningsBookingDataSource earningsBookingDataSource;

  GetLast7DaysIncomeUseCase(this.earningsBookingDataSource);

  Stream<List<IncomeData>> execute() async* {
    String id = await SharedPreferencesHelper.getUserId();
    yield* earningsBookingDataSource.getAllBookings(id).map((bookings) {
      Map<DateTime, double> earningsByDate = {};
      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(Duration(days: 7));

      for (var booking in bookings) {
        try {
          // Print the date for debugging purposes
          print('Booking date string: ${booking.bookingDateTime}');

          DateTime bookingDate = DateTime.parse(booking.bookingDateTime);

          if (bookingDate.isAfter(sevenDaysAgo)) {
            // Normalize the date to just the date (ignoring time)
            DateTime normalizedDate =
                DateTime(bookingDate.year, bookingDate.month, bookingDate.day);

            // Parse payment amount
            double payment = double.parse(booking.totalPayment);

            // Update earningsByDate map
            if (earningsByDate.containsKey(normalizedDate)) {
              earningsByDate[normalizedDate] =
                  earningsByDate[normalizedDate]! + payment;
            } else {
              earningsByDate[normalizedDate] = payment;
            }
          }
        } catch (e) {
          // Handle date parsing errors
          print('Date parsing error: ${e.toString()}');
        }
      }

      // Generate a list of all dates in the last 7 days
      List<DateTime> allDates = List.generate(8, (index) {
        return DateTime.now().subtract(Duration(days: 7 - index));
      }).map((date) => DateTime(date.year, date.month, date.day)).toList();

      // Ensure all dates are included in the results
      List<IncomeData> incomeList = allDates.map((date) {
        double amount = earningsByDate[date] ?? 0.0;
        return IncomeData(date: date, amount: amount);
      }).toList();

      return incomeList;
    });
  }
}
