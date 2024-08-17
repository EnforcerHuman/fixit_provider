part of 'chat_bloc.dart';

abstract class ChatEvent {}

class LoadConversations extends ChatEvent {}

class LoadMessages extends ChatEvent {
  final String conversationId;

  LoadMessages(this.conversationId);
}

class SendMessageEvent extends ChatEvent {
  final String conversationId;
  final String text;

  SendMessageEvent(this.conversationId, this.text);
}
