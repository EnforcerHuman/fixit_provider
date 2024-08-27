import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/earnings/data/earnings_booking_data_source.dart';
import 'package:fixit_provider/features/earnings/data/models/day_booking.dart';

class GetDailyBookingOverviewUseCase {
  final EarningsBookingDataSource earningsBookingDataSource;

  GetDailyBookingOverviewUseCase(this.earningsBookingDataSource);

  Future<DailyBooking> call(String date) async {
    List<BookingModel> bookings = [];
    String providerId = await SharedPreferencesHelper.getUserId();
    double totalEarning = 0;
    int totalBookings = 0;

    // Get the stream of daily bookings from the data source
    Stream<List<BookingModel>> dailyBookingsStream =
        earningsBookingDataSource.getDailyBookings(providerId);

    // Process the first snapshot of the stream
    final dailyBookings = await dailyBookingsStream.first;

    for (var booking in dailyBookings) {
      if (booking.bookingDateTime == date) {
        totalBookings++;
        bookings.add(booking);
        totalEarning += double.parse(booking.totalPayment);
      }
    }

    DailyBooking dayBooking =
        DailyBooking(totalEarning, totalBookings, bookings);
    return dayBooking;
  }
}
