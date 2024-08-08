part of 'cancelled_bookings_bloc.dart';

@immutable
sealed class CancelledBookingsEvent {}

class GetCancelledBookings extends CancelledBookingsEvent {
  final String id;

  GetCancelledBookings(this.id);
}
