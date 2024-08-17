import 'package:fixit_provider/features/chat/data/data_source/firebase_chat_data_source.dart';
import 'package:fixit_provider/features/chat/data/repositories/chat_repository.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseChatDatasource datasource;

  ChatRepositoryImpl(this.datasource);

  @override
  Stream<List<Conversation>> getConversations(String userId) {
    return datasource.getConversations(userId);
  }

  @override
  Stream<List<Message>> getMessages(String conversationId) {
    return datasource.getMessages(conversationId);
  }

  // @override
  // Future<void> sendMessage(String conversationId, String text) {
  //   return datasource.sendMessage(conversationId, text);
  // }

  // @override
  // Future<String> createConversation(String otherUserId) {
  //   return datasource.createConversation(otherUserId);
  // }
}
