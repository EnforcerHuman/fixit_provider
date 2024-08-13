part of 'request_status_bloc.dart';

@immutable
sealed class RequestStatusEvent {}

class AcceptBooking extends RequestStatusEvent {
  final String date;
  final String id;
  final String status;

  AcceptBooking(this.date, this.id, this.status);
}

class RejectBooking extends RequestStatusEvent {
  final String date;
  final String id;
  final String status;

  RejectBooking(this.date, this.id, this.status);
}
