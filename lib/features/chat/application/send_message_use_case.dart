import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugtugan/features/chat/domain/chat_repository.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';
import 'package:tugtugan/features/chat/domain/studio_chat_model.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<void> execute(MessageModel messageModel) async {
    final messageId = await repository.sendMessage(messageModel);

    final updatedChat = StudioChatModel(
      clientId: messageModel.clientId,
      studioId: messageModel.studioId,
      lastMessage: messageModel.message,
      lastMessageSenderId: messageModel.clientId,
      lastMessageTimeSent: Timestamp.now(),
      lastMessageType: "text",
      lastMessageId: messageId,
      studioChatId: "${messageModel.studioId}${messageModel.clientId}",
      members: {
        messageModel.studioId: ChatMembers(
          isAdmin: false,
          receiveNotification: true,
        ),
        messageModel.clientId: ChatMembers(
          isAdmin: true,
          receiveNotification: true,
          lastMessageIdRead: messageId,
        ),
      },
    );

    await repository.updateInbox(updatedChat);
  }
}
