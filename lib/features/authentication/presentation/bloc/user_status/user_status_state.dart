part of 'user_status_bloc.dart';

@immutable
sealed class UserStatusState {}

final class UserStatusInitial extends UserStatusState {}

class UserVerified extends UserStatusState {}

class UserNotVerified extends UserStatusState {}

class UserStatusFailure extends UserStatusState {}

class UserStatusChecking extends UserStatusState {}
