part of 'payment_request_bloc.dart';

@immutable
sealed class PaymentRequestState {}

final class PaymentRequestInitial extends PaymentRequestState {}

class PaymentRequested extends PaymentRequestState {}

class PaymentRequestFailed extends PaymentRequestState {}
