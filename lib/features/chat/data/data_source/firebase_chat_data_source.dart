import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit_provider/features/chat/data/models/conversation_model.dart';
import 'package:fixit_provider/features/chat/data/models/message_model.dart';

class FirebaseChatDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> sendMessage(ConversationModel conversation, MessageModel message,
      String userName, String providerName) async {
    // Optionally set or update the document in the 'conversations' collection
    await firebaseFirestore
        .collection('conversations')
        .doc(conversation.id)
        .set({
      'userName': userName,
      'providerName': providerName,
      'participants': conversation.participants,
      'lastMessage': message.toMap(),
    }, SetOptions(merge: true));

    // Add the new message to the 'messages' subcollection
    await firebaseFirestore
        .collection('conversations')
        .doc(conversation.id)
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<ConversationModel>> getConversations(String userId) {
    return firebaseFirestore
        .collection('conversations')
        .where('participants', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ConversationModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Stream<List<MessageModel>> getMessages(String conversationId) {
    return firebaseFirestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              MessageModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}
