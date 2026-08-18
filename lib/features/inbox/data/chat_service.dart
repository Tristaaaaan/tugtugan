import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/inbox_repository.dart';

class InboxService implements InboxRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> updateLastReadMessage(
      String studioId, String clientId, String messageId) async {
    await _firestore
        .collection('studios')
        .doc(studioId)
        .collection('inbox')
        .doc('$studioId$clientId')
        .update({
      'members.$clientId.lastMessageIdRead': messageId,
    });
  }
}
