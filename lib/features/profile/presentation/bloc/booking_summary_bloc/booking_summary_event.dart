part of 'booking_summary_bloc.dart';

@immutable
sealed class BookingSummaryEvent {}

final class LoadBookingOverview extends BookingSummaryEvent {}
