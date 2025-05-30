import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugtugan/features/chat/domain/chat_repository.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';
import 'package:tugtugan/features/chat/domain/studio_chat_model.dart';

class ChatService implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<String> sendMessage(MessageModel messageModel) async {
    final docRef = await _firestore
        .collection('studios')
        .doc(messageModel.studioId)
        .collection('inbox')
        .doc('${messageModel.studioId}${messageModel.clientId}')
        .collection('messages')
        .add(messageModel.toMap());

    return docRef.id;
  }

  @override
  Future<void> updateInbox(StudioChatModel chatModel) async {
    await _firestore
        .collection('studios')
        .doc(chatModel.studioId)
        .collection('inbox')
        .doc('${chatModel.studioId}${chatModel.clientId}')
        .set(chatModel.toMap());
  }

  @override
  Stream<List<MessageModel>> streamMessages(
    String studioId,
    String clientId,
  ) {
    return _firestore
        .collection('studios')
        .doc(studioId)
        .collection('inbox')
        .doc('$studioId$clientId')
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(20) // Limit to the last 100 messages
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessageModel.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Stream<StudioChatModel> streamSpecificStudio(String studioId) {
    return _firestore
        .collection('studios')
        .doc(studioId)
        .collection('inbox')
        .where('studioId', isEqualTo: studioId)
        .limit(1) // Only fetch one document
        .snapshots()
        .map((snapshot) {
      return StudioChatModel.fromMap(snapshot.docs.first.data());
    });
  }
}
