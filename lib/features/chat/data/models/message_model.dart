import '../../domain/entities/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends Message {
  MessageModel({
    required String id,
    required String senderId,
    required String text,
    required DateTime timestamp,
  }) : super(id: id, senderId: senderId, text: text, timestamp: timestamp);

  factory MessageModel.fromMap(Map<String, dynamic> map, String id) {
    return MessageModel(
      id: id,
      senderId: map['senderId'],
      text: map['text'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
