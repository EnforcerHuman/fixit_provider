import 'package:fixit_provider/features/booking/data/model/booking_model.dart';

class DailyBooking {
  final double amount;
  final int totalBooking;
  final List<BookingModel> bookingsofDay;

  DailyBooking(this.amount, this.totalBooking, this.bookingsofDay);
}
