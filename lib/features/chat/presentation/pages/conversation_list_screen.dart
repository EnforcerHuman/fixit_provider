import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/features/chat/data/models/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:intl/intl.dart';
import 'chat_screen.dart';

class ConversationListScreen extends StatelessWidget {
  const ConversationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(LoadConversations());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Conversations',
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ConversationsLoaded) {
            if (state.conversations.isEmpty) {
              return const EmptyState();
            } else {
              return ConversationList(conversations: state.conversations);
            }
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  }
}

class ConversationList extends StatelessWidget {
  final List<ConversationModel> conversations;

  const ConversationList({super.key, required this.conversations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return ConversationListItem(conversation: conversation);
      },
    );
  }
}

class ConversationListItem extends StatelessWidget {
  final ConversationModel conversation;

  const ConversationListItem({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    final formattedTime =
        DateFormat.jm().format(conversation.lastMessage.timestamp);
    bool textoverflow = conversation.lastMessage.text.length > 3;
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person_2_outlined),
          ),
          title: Text(conversation.userName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(conversation.lastMessage.text,
                  overflow: textoverflow
                      ? TextOverflow.ellipsis
                      : TextOverflow.ellipsis),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
          trailing: Text(formattedTime),
          onTap: () async {
            final userId = await SharedPreferencesHelper.getUserId();

            Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  currentUserId: userId,
                  conversationId: conversation.id,
                  conversation: conversation,
                  currentUsername: conversation.userName,
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 13,
        )
      ],
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('NO CONVERSATIONS'),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
