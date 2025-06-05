import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:tugtugan/features/chat/domain/studio_chat_model.dart';

class RealTimeInboxRepository {
  final String userId;
  final List<StudioChatModel> inbox = [];
  DocumentSnapshot? _lastFetchedDocument;
  bool hasMoreInbox = true;

  late final Query<StudioChatModel> _inboxQuery = FirebaseFirestore.instance
      .collectionGroup('inbox')
      .where('memberIds', arrayContains: userId)
      .orderBy('lastMessageTimeSent', descending: true)
      .withConverter<StudioChatModel>(
        fromFirestore: (snapshot, _) =>
            StudioChatModel.fromMap(snapshot.data()!),
        toFirestore: (chat, _) => chat.toMap(),
      );

  RealTimeInboxRepository({required this.userId});

  /// Realtime stream sorted by lastMessageTimeSent (descending)
  Stream<List<StudioChatModel>> get inboxStream {
    return _inboxQuery.snapshots().map((snapshot) {
      inbox
        ..clear()
        ..addAll(snapshot.docs.map((doc) => doc.data()));

      // Update pagination tracker
      if (snapshot.docs.isNotEmpty) {
        _lastFetchedDocument = snapshot.docs.last;
      }

      return List<StudioChatModel>.from(inbox);
    });
  }

  /// Load more messages for pagination
  Future<void> loadMoreInbox({int limit = 10}) async {
    if (!hasMoreInbox) return;

    try {
      Query<StudioChatModel> query = _inboxQuery.limit(limit);
      if (_lastFetchedDocument != null) {
        query = query.startAfterDocument(_lastFetchedDocument!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        final newItems = snapshot.docs.map((doc) => doc.data()).toList();
        inbox.addAll(newItems);

        _lastFetchedDocument = snapshot.docs.last;
        hasMoreInbox = snapshot.docs.length >= limit;
      } else {
        hasMoreInbox = false;
      }
    } catch (e) {
      debugPrint('Error loading more inbox: $e');
      hasMoreInbox = false;
    }
  }

  /// Reset for new queries
  void reset() {
    inbox.clear();
    _lastFetchedDocument = null;
    hasMoreInbox = true;
  }
}
