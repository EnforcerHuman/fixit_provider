import 'package:fixit_provider/features/chat/data/repositories/chat_repository.dart';

import '../entities/message.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Stream<List<Message>> execute(String conversationId) {
    return repository.getMessages(conversationId);
  }
}
