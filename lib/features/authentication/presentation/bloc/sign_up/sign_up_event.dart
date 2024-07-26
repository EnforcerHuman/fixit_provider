part of 'sign_up_bloc.dart';

sealed class SignUpEvent {}

class SendOTPEvent extends SignUpEvent {
  final String phone;

  SendOTPEvent(this.phone);
}

class VerifyOTPEvent extends SignUpEvent {
  final String otp;
  final String verificationId;
  final String email;
  final String password;

  VerifyOTPEvent(this.otp, this.verificationId, this.email, this.password);
}

class LinkEmailPasswordEvent extends SignUpEvent {
  final String email;
  final String password;

  LinkEmailPasswordEvent(this.email, this.password);
}
