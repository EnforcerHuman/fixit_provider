part of 'booking_summary_bloc.dart';

@immutable
sealed class BookingSummaryState {}

final class BookingSummaryInitial extends BookingSummaryState {}

final class BookingSummaryLoaded extends BookingSummaryState {
  final BookingOverView bookingOverView;

  BookingSummaryLoaded(this.bookingOverView);
}

final class BookingSummaryError extends BookingSummaryState {
  final String error;

  BookingSummaryError(this.error);
}
