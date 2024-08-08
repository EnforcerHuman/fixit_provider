part of 'requested_bookings_bloc.dart';

@immutable
sealed class RequestedBookingsEvent {}

class GetRequestedBooking extends RequestedBookingsEvent {}
