part of 'payment_bloc.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccessful extends PaymentState {}

class PaymentFailed extends PaymentState {
  final String errorMessage;
  PaymentFailed(this.errorMessage);
}

class ExternalWalletUsed extends PaymentState {
  final String walletName;
  ExternalWalletUsed(this.walletName);
}
