part of 'completed_bookings_bloc.dart';

@immutable
sealed class CompletedBookingsState {}

final class CompletedBookingsInitial extends CompletedBookingsState {}

class CompletedBookinsLoaded extends CompletedBookingsState {
  final List<BookingModel> completedBookings;

  CompletedBookinsLoaded(this.completedBookings);
}

class CompletedBookingsFailed extends CompletedBookingsState {
  final String message;

  CompletedBookingsFailed(this.message);
}

class CompletedBookingsLoading extends CompletedBookingsState {}
