part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class VerifySignIn extends SignInEvent {
  final SignInUseCase signInUseCase;
  final String email;
  final String password;
  final BuildContext context;
  VerifySignIn(this.signInUseCase, this.email, this.password, this.context);
}

class ForgotPassword extends SignInEvent {}
