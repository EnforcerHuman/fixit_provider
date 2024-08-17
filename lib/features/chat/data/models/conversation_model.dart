import 'package:fixit_provider/features/chat/data/models/message_model.dart';
import '../../domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  ConversationModel({
    required String id,
    required List<String> participants,
    required MessageModel lastMessage,
    required String userName,
    required String providerName,
  }) : super(
            id: id,
            participants: participants,
            lastMessage: lastMessage,
            userName: userName,
            providerName: providerName);

  factory ConversationModel.fromMap(Map<String, dynamic> map, String id) {
    return ConversationModel(
      id: id,
      participants: List<String>.from(map['participants']),
      lastMessage: MessageModel.fromMap(map['lastMessage'], ''),
      userName: map['userName'] ?? '', // Default value if not present
      providerName: map['providerName'] ?? '', // Default value if not present
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastMessage': (lastMessage as MessageModel).toMap(),
      'userName': userName,
      'providerName': providerName,
    };
  }
}
