part of 'completed_bookings_bloc.dart';

@immutable
sealed class CompletedBookingsEvent {}

class GetCompletedBooking extends CompletedBookingsEvent {}
