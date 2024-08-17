part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  // final Stream<List<Conversation>> conversations;
  final List<ConversationModel> conversations;
  ConversationsLoaded(this.conversations);
}

class MessagesLoaded extends ChatState {
  final List<Message> messages;

  MessagesLoaded(this.messages);
}

class MessageError extends ChatState {}

class ConversationError extends ChatState {
  final String error;

  ConversationError(this.error);
}
