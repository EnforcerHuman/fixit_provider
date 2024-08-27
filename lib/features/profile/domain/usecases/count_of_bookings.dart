import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/data/data_source/booking_remote_data_source.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/profile/data/model/booking_over_view.dart';

class CountOfBookings {
  final BookingRemotedataSource bookingRemotedDataSource;

  CountOfBookings(this.bookingRemotedDataSource);

  Stream<BookingOverView> execute() async* {
    String id = await SharedPreferencesHelper.getUserId();
    await for (List<BookingModel> bookings
        in bookingRemotedDataSource.getBookings(id)) {
      List<BookingModel> completedBookings = [];
      for (var booking in bookings) {
        if (booking.status == 'Completed') {
          completedBookings.add(booking);
        }
      }
      int bookingCount = completedBookings.length;
      double totalEarnings = completedBookings.fold(0.0, (sum, booking) {
        double payment = 0.0;
        try {
          payment = double.parse(booking.totalPayment);
        } catch (e) {
          // Handle parsing error if needed (e.g., log the error)
        }
        return sum + payment;
      });

      yield BookingOverView(bookingCount, totalEarnings);
    }
  }
}
