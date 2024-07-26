part of 'sign_in_bloc.dart';

sealed class SignInState {}

final class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  final String navigationTarget;

  SignInSuccess(this.navigationTarget);
}

class SignInFailed extends SignInState {}

class SignInLoading extends SignInState {}
