part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}

class SentResetLink extends ForgotPasswordEvent {
  final String email;

  SentResetLink(this.email);
}
