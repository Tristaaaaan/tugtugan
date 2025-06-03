import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';
import 'package:tugtugan/features/chat/domain/studio_chat_model.dart';

abstract class ChatRepository {
  Future<String> sendMessage(MessageModel messageModel);
  Future<void> updateInbox(StudioChatModel studioChatModel);
  Stream<List<MessageModel>> streamMessages(String studioId, String clientId);

  Stream<StudioChatModel?> streamSpecificStudio(
      String studioI, String clientId);
  Stream<List<StudioChatModel>> streamUserInboxStudio(String clientId);
}

class RealTimeChatRepository {
  final String studioId;
  final String clientId;
  final List<MessageModel> users = [];
  QuerySnapshot<MessageModel>? userQuerySnapshot;

  bool hasNextUser = true;

  late final CollectionReference<MessageModel> _firestoreUser =
      FirebaseFirestore.instance
          .collection('studios')
          .doc(studioId)
          .collection("inbox")
          .doc("$studioId$clientId")
          .collection("messages")
          .withConverter<MessageModel>(
            fromFirestore: (snapshot, _) =>
                MessageModel.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );

  RealTimeChatRepository({required this.studioId, required this.clientId});

  // Realtime stream of messages
  Stream<QuerySnapshot<MessageModel>> get messagesStream {
    return _firestoreUser.orderBy('timestamp', descending: true).snapshots();
  }

  // For initial load and pagination
  Future<List<MessageModel>> fetchUsers([int limitTo = 20]) async {
    try {
      Query<MessageModel> query =
          _firestoreUser.orderBy('timestamp', descending: true).limit(limitTo);

      if (userQuerySnapshot != null && userQuerySnapshot!.docs.isNotEmpty) {
        final lastDoc = userQuerySnapshot!.docs.last;
        query = query.startAfterDocument(lastDoc);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        userQuerySnapshot = snapshot;

        for (final doc in snapshot.docs) {
          final user = doc.data();
          final index = users.indexWhere((u) => u.messageId == user.messageId);
          if (index != -1) {
            users[index] = user;
          } else {
            users.add(user);
          }
        }

        if (snapshot.docs.length < limitTo) {
          hasNextUser = false;
        }
      } else {
        hasNextUser = false;
      }
    } catch (e) {
      debugPrint('Error fetching users: $e');
    }

    return users;
  }
}
