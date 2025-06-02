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
        .doc('${messageModel.studioId}${messageModel.senderId}')
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
        .limit(20)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList();
      },
    );
  }

  @override
  Stream<StudioChatModel?> streamSpecificStudio(
      String studioId, String clientId) {
    final docId = '$studioId$clientId';
    return _firestore
        .collection('studios')
        .doc(studioId)
        .collection('inbox')
        .doc(docId)
        .snapshots()
        .map(
      (docSnapshot) {
        if (!docSnapshot.exists) return null;
        return StudioChatModel.fromMap(docSnapshot.data()!);
      },
    );
  }

  @override
  Stream<List<StudioChatModel>> streamUserInboxStudio(String clientId) {
    return _firestore
        .collectionGroup('inbox')
        .where('memberIds', arrayContains: clientId)
        .orderBy('lastMessageTimeSent', descending: true)
        .orderBy("__name__", descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => StudioChatModel.fromMap(doc.data()))
          .toList();
    });
  }
}
