import 'package:fixit_provider/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit_provider/features/chat/data/models/conversation_model.dart';
import 'package:fixit_provider/features/chat/data/models/message_model.dart';
import 'package:fixit_provider/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:fixit_provider/features/chat/domain/entities/message.dart';
import 'package:fixit_provider/features/chat/domain/usecases/get_messages.dart';
import 'package:fixit_provider/features/chat/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final String conversationId;
  final ConversationModel conversation;
  final String currentUserId;

  ChatScreen({
    required this.conversationId,
    required this.conversation,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(
        GetMessages(ChatRepositoryImpl(FirebaseChatDatasource())),
      )..add(GetMessagesEvent(conversationId)),
      child: ChatScreenView(
        conversationId: conversationId,
        conversation: conversation,
        currentUserId: currentUserId,
      ),
    );
  }
}

class ChatScreenView extends StatelessWidget {
  final String conversationId;
  final ConversationModel conversation;
  final String currentUserId;
  final TextEditingController _messageController = TextEditingController();

  ChatScreenView({
    required this.conversationId,
    required this.conversation,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessagesLoaded) {
                  return MessageList(
                    messages: state.messages,
                    currentUserId: currentUserId,
                  );
                } else if (state is MessagesError) {
                  return Center(child: Text('Error: '));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          MessageInput(
            messageController: _messageController,
            onSendMessage: _onSendMessage,
          ),
        ],
      ),
    );
  }

  void _onSendMessage(BuildContext context) {
    if (_messageController.text.isNotEmpty) {
      final message = MessageModel(
        id: DateTime.now().toString(),
        senderId: currentUserId,
        text: _messageController.text,
        timestamp: DateTime.now(),
      );

      ConversationModel updatedConversation = ConversationModel(
          id: conversationId,
          participants: conversation.participants,
          lastMessage: message,
          userName: conversation.userName,
          providerName: conversation.providerName);

      final firebaseChatDatasource = FirebaseChatDatasource();
      firebaseChatDatasource.sendMessage(
        updatedConversation,
        message,
        'Melbin',
        conversation.providerName,
      );

      _messageController.clear();
    }
  }
}

class MessageList extends StatelessWidget {
  final List<Message> messages;
  final String currentUserId;

  const MessageList({
    required this.messages,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isSentByCurrentUser = message.senderId == currentUserId;

        return Align(
          alignment: isSentByCurrentUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSentByCurrentUser
                  ? Colors.blueAccent
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: isSentByCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: isSentByCurrentUser ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController messageController;
  final void Function(BuildContext) onSendMessage;

  const MessageInput({
    required this.messageController,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(hintText: 'Enter message'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => onSendMessage(context),
          ),
        ],
      ),
    );
  }
}
