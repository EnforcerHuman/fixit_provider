import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/data/data_source/booking_remote_data_source.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';

class BookingUseCase {
  BookingRemotedataSource bookingRemotedataSource = BookingRemotedataSource();

  Stream<List<BookingModel>> getPendingBooking(String id) {
    return bookingRemotedataSource.getBookings(id).map((bookings) {
      print(bookings);
      return bookings
          .where((booking) => booking.status == 'Requested')
          .toList();
    });
  }

  Stream<List<BookingModel>> getAcceptedBooking(String date, String id) {
    return bookingRemotedataSource.getBookings(id).map((bookings) {
      return bookings
          .where((booking) =>
              booking.status == 'Accepted' && booking.bookingDateTime == date)
          .toList();
    });
  }

  Stream<List<BookingModel>> getRejectedBookings(String id) {
    return bookingRemotedataSource.getBookings(id).map((bookings) {
      return bookings.where((booking) => booking.status == 'Rejected').toList();
    });
  }
}
