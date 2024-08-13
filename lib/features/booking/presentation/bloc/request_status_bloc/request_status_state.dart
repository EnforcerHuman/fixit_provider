part of 'request_status_bloc.dart';

@immutable
sealed class RequestStatusState {}

final class RequestStatusInitial extends RequestStatusState {}

class RequestAccepted extends RequestStatusState {}

class RequestRejected extends RequestStatusState {}

class StatusUpdateFailed extends RequestStatusState {}

class BookingStatusUpdating extends RequestStatusState {}
