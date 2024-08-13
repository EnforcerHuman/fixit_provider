import 'package:fixit_provider/features/booking/data/data_source/booking_remote_data_source.dart';

class UpdateBookingStatusUsecases {
  BookingRemotedataSource bookingRemotedataSource = BookingRemotedataSource();

  Future<void> rejectBooking(String id) async {
    bookingRemotedataSource.updateBookingStatus(id, 'Rejected', '');
  }

  Future<void> acceptBooking(String id, String date) async {
    bookingRemotedataSource.updateBookingStatus(id, 'Accepted', date);
  }

  Future<void> requestPayment(String id, String amount) async {
    bookingRemotedataSource.updatePaymentRequest(id, amount);
  }
}
