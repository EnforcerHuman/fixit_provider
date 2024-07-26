part of 'user_status_bloc.dart';

@immutable
sealed class UserStatusEvent {}

class CheckUserStatus extends UserStatusEvent {
  final String userId;

  CheckUserStatus(this.userId);
}
