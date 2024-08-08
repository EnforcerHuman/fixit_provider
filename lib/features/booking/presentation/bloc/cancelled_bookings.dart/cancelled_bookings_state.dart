part of 'cancelled_bookings_bloc.dart';

@immutable
sealed class CancelledBookingsState {}

final class CancelledBookingsInitial extends CancelledBookingsState {}

class CancelledBookingsLoaded extends CancelledBookingsState {
  final List<BookingModel> cancelledBookings;

  CancelledBookingsLoaded(this.cancelledBookings);
}

class CancelledBookingsFailed extends CancelledBookingsState {
  final String reason;

  CancelledBookingsFailed(this.reason);
}

class CancelledBookingError extends CancelledBookingsState {
  final String error;

  CancelledBookingError(this.error);
}
