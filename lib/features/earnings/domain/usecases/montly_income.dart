import 'package:intl/intl.dart';
import 'dart:async';
import 'package:fixit_provider/features/earnings/data/models/monthly_overview.dart';
import 'package:fixit_provider/features/earnings/data/earnings_booking_data_source.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';

class GetMonthlyOverviewUseCase {
  final EarningsBookingDataSource earningsBookingDataSource;

  GetMonthlyOverviewUseCase(this.earningsBookingDataSource);

  Stream<List<MonthlyOverview>> execute(String providerId, int year) async* {
    List<MonthlyOverview> monthlyOverviews = [];

    // Get the current month
    int currentMonth = DateTime.now().month;

    for (int month = 1; month <= currentMonth; month++) {
      // Fetch bookings for the current month
      List<BookingModel> bookings = await earningsBookingDataSource
          .getMonthlyBookings(providerId, month, year)
          .first;

      double totalEarnings = 0.0;
      int totalBookings = 0;

      if (bookings.isNotEmpty) {
        // Calculate total earnings for the current month
        totalEarnings = bookings.fold(0.0, (sum, booking) {
          double payment = 0.0;
          try {
            payment = double.parse(booking.totalPayment);
          } catch (e) {
            // Handle parsing error if needed
          }
          return sum + payment;
        });

        totalBookings = bookings.length;
      }

      // Format the month and year
      String monthYear = DateFormat.yMMMM().format(DateTime(year, month));

      // Create a MonthlyOverview object and add it to the list
      monthlyOverviews.add(MonthlyOverview(
        monthYear,
        totalBookings.toString(),
        totalEarnings.toStringAsFixed(2),
      ));
    }

    // Yield the list of monthly overviews
    yield monthlyOverviews;
  }
}
