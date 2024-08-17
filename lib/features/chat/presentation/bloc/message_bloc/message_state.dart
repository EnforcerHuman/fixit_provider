part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessagesLoaded extends MessageState {
  final List<Message> messages;

  MessagesLoaded(this.messages);
}

final class MessagesError extends MessageState {
  final String error;

  MessagesError(this.error);
}
