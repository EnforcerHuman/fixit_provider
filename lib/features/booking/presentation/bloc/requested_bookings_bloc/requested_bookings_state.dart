part of 'requested_bookings_bloc.dart';

@immutable
sealed class RequestedBookingsState {}

final class RequestedBookingsInitial extends RequestedBookingsState {}

class RequestedBookingLoaded extends RequestedBookingsState {
  final List<BookingModel> requestedBooking;

  RequestedBookingLoaded(this.requestedBooking);
}

class RequestedBookingFailed extends RequestedBookingsState {
  final String failedReason;

  RequestedBookingFailed(this.failedReason);
}

class RequestedBookingError extends RequestedBookingsState {
  final String errorMessage;

  RequestedBookingError(this.errorMessage);
}
