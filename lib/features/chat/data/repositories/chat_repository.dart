import 'package:fixit_provider/features/chat/domain/entities/conversation.dart';
import 'package:fixit_provider/features/chat/domain/entities/message.dart';

abstract class ChatRepository {
  Stream<List<Conversation>> getConversations(String userId);
  Stream<List<Message>> getMessages(String conversationId);
  // Future<void> sendMessage(String conversationId, String text);
  // Future<String> createConversation(String otherUserId);
}
