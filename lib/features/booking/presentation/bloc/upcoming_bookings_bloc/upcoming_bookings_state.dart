part of 'upcoming_bookings_bloc.dart';

@immutable
sealed class UpcomingBookingsState {}

final class UpcomingBookingsInitial extends UpcomingBookingsState {}

class UpcomingBookingLoaded extends UpcomingBookingsState {
  final List<BookingModel> upcomingBookings;

  UpcomingBookingLoaded(this.upcomingBookings);
}

class UpcomingBookingFailed extends UpcomingBookingsState {}

class UpcomingBookingError extends UpcomingBookingsState {}
