part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

class ResetLinkSent extends ForgotPasswordState {}

class ResetLinkSentFailed extends ForgotPasswordState {
  final String error;

  ResetLinkSentFailed(this.error);
}

class ResetLinkSending extends ForgotPasswordState {}
