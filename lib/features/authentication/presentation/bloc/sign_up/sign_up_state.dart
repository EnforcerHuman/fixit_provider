part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class OTPSentState extends SignUpState {
  final String verificationId;

  OTPSentState(this.verificationId);
}

class OtpSendingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final UserCredential userCredential;
  SignUpSuccessState(this.userCredential);
}

class EmailPasswordLinkedState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState(this.error);
}

class OtpVerifyingState extends SignUpState {}
