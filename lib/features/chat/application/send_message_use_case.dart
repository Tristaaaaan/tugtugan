import 'package:tugtugan/features/chat/domain/chat_repository.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';
import 'package:tugtugan/features/chat/domain/studio_chat_model.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> execute(MessageModel messageModel) async {
    final messageId = await repository.sendMessage(messageModel);

    final updatedChat = StudioChatModel(
      clientId: messageModel.senderId,
      studioId: messageModel.studioId,
      lastMessage: messageModel.message,
      lastMessageSenderId: messageModel.senderId,
      lastMessageTimeSent: messageModel.timestamp,
      lastMessageType: "text",
      lastMessageId: messageId,
      studioChatId: "${messageModel.studioId}${messageModel.senderId}",
      members: {
        messageModel.studioId: ChatMembers(
          isAdmin: false,
          receiveNotification: true,
        ),
        messageModel.senderId: ChatMembers(
          isAdmin: true,
          receiveNotification: true,
          lastMessageIdRead: messageId,
        ),
      },
      memberIds: [messageModel.studioId, messageModel.senderId],
    );

    await repository.updateInbox(updatedChat);
  }
}
