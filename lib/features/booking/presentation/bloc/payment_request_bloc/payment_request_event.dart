part of 'payment_request_bloc.dart';

@immutable
sealed class PaymentRequestEvent {}

class RequestPayment extends PaymentRequestEvent {
  final String id;
  final String amount;

  RequestPayment(this.id, this.amount);
}
