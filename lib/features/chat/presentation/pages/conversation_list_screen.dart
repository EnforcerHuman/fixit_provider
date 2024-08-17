import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_screen.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(LoadConversations());
    return Scaffold(
      appBar: AppBar(title: Text('Conversations')),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          print('*******************');
          print(state);
          if (state is ConversationsLoaded) {
            if (state.conversations.isEmpty) {
              return Center(
                child: Text('NO CONVERSATIONS'),
              );
            } else {
              print('*******************');
              print(state.conversations.length);
              return ListView.builder(
                itemCount: state.conversations.length,
                itemBuilder: (context, index) {
                  final conversation = state.conversations[index];
                  return ListTile(
                    leading: CircleAvatar(),
                    title: Text(conversation.userName),
                    subtitle: Text(conversation.lastMessage.text),
                    onTap: () async {
                      String userId = await SharedPreferencesHelper.getUserId();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            currentUserId: userId,
                            conversationId: conversation.id,
                            conversation: conversation,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Implement logic to start a new conversation
        },
      ),
    );
  }
}
