part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

final class GetMessagesEvent extends MessageEvent {
  final String conversationId;

  GetMessagesEvent(this.conversationId);
}
