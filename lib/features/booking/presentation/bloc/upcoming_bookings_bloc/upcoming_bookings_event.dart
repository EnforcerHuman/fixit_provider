part of 'upcoming_bookings_bloc.dart';

@immutable
sealed class UpcomingBookingsEvent {}

class GetUpcomingBookings extends UpcomingBookingsEvent {
  final String date;
  final String id;
  GetUpcomingBookings(this.date, this.id);
}
