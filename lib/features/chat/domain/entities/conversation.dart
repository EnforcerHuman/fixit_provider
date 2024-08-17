import 'package:fixit_provider/features/chat/domain/entities/message.dart';

class Conversation {
  final String id;
  final List<String> participants;
  final Message lastMessage;
  final String userName;
  final String providerName;

  Conversation({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.userName,
    required this.providerName,
  });
}
