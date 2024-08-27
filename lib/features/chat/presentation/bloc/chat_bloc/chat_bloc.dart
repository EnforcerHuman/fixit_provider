import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit_provider/features/chat/data/models/conversation_model.dart';
import 'package:fixit_provider/features/chat/domain/entities/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  // final GetConversations getConversations;
  // final GetMessages getMessages;
  // final SendMessage sendMessage;

  ChatBloc(
      // {
      // required this.getConversations,
      // required this.getMessages,
      // required this.sendMessage,
      // }
      )
      : super(ChatInitial()) {
    FirebaseChatDatasource firebaseChatDatasource = FirebaseChatDatasource();

    on<LoadConversations>((event, emit) async {
      String userId = await SharedPreferencesHelper.getUserId();
      await emit.forEach<List<ConversationModel>>(
          firebaseChatDatasource.getConversations(userId),
          onData: (data) {
            return ConversationsLoaded(data);
          },
          onError: (error, stackTrace) => ConversationError(error.toString()));
    });

    on<LoadMessages>((event, emit) async {
      await emit.forEach<List<Message>>(
          firebaseChatDatasource.getMessages(event.conversationId),
          onData: (data) => MessagesLoaded(data),
          onError: (error, stackTrace) => MessageError());
    });
  }

  //   await sendMessage(event.conversationId, event.text);
  // }
}
