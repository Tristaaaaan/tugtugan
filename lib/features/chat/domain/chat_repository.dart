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
