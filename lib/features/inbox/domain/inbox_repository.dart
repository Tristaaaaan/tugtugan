abstract class InboxRepository {
  Future<void> updateLastReadMessage(
      String messageId, String studioId, String userId);
}
