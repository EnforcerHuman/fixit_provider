import 'package:fixit_provider/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit_provider/features/chat/data/models/conversation_model.dart';
import 'package:fixit_provider/features/chat/data/models/message_model.dart';
import 'package:fixit_provider/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:fixit_provider/features/chat/domain/entities/message.dart';
import 'package:fixit_provider/features/chat/domain/usecases/get_messages.dart';
import 'package:fixit_provider/features/chat/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  final String conversationId;
  final ConversationModel conversation;
  final String currentUserId;
  final String currentUsername;
  const ChatScreen({
    super.key,
    required this.conversationId,
    required this.conversation,
    required this.currentUserId,
    required this.currentUsername,
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
        currentUsername: currentUsername,
      ),
    );
  }
}

class ChatScreenView extends StatelessWidget {
  final String conversationId;
  final ConversationModel conversation;
  final String currentUserId;
  final TextEditingController _messageController = TextEditingController();
  final String currentUsername;

  ChatScreenView({
    super.key,
    required this.conversationId,
    required this.conversation,
    required this.currentUserId,
    required this.currentUsername,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
          title: Text(currentUsername)),
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
                  return const Center(child: Text('Error: '));
                } else {
                  return const Center(child: CircularProgressIndicator());
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
        currentUsername,
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
    super.key,
    required this.messages,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    // Group messages by date
    Map<DateTime, List<Message>> groupedMessages = {};
    for (var message in messages) {
      final messageDate = DateTime(
        message.timestamp.year,
        message.timestamp.month,
        message.timestamp.day,
      );
      if (!groupedMessages.containsKey(messageDate)) {
        groupedMessages[messageDate] = [];
      }
      groupedMessages[messageDate]!.add(message);
    }

    // Create a list of date headers with messages under them
    final groupedMessagesList = groupedMessages.entries.toList();

    return ListView.builder(
      reverse: true,
      itemCount: groupedMessagesList.length,
      itemBuilder: (context, index) {
        final entry = groupedMessagesList[index];
        final date = entry.key;
        final messages =
            entry.value.reversed.toList(); // Reverse the order of messages

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                DateFormat.yMMMd().format(date), // Format the date as needed
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            ...messages.map((message) {
              final isSentByCurrentUser = message.senderId == currentUserId;
              final formattedTime =
                  DateFormat.jm().format(message.timestamp); // Format the time

              return Align(
                alignment: isSentByCurrentUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                          color:
                              isSentByCurrentUser ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(
                          height: 4), // Add some spacing between text and time
                      Text(
                        formattedTime, // Display the formatted time
                        style: TextStyle(
                          fontSize: 10,
                          color: isSentByCurrentUser
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
              // ignore: unnecessary_to_list_in_spreads
            }).toList(),
          ],
        );
      },
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController messageController;
  final void Function(BuildContext) onSendMessage;

  const MessageInput({
    super.key,
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
              decoration: const InputDecoration(hintText: 'Enter message'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => onSendMessage(context),
          ),
        ],
      ),
    );
  }
}
