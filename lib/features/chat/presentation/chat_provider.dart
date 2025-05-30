import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tugtugan/features/chat/data/chat_service.dart';
import 'package:tugtugan/features/chat/domain/chat_repository.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';
import 'package:tugtugan/features/chat/domain/studio_chat_model.dart';

final chatServiceProvider = Provider<ChatRepository>((ref) {
  return ChatService();
});

final combinedChatProvider = StreamProvider.family<
    ({List<MessageModel> messages, StudioChatModel? chat}),
    (String studioId, String clientId)>((ref, params) {
  final chatService = ref.watch(chatServiceProvider);
  final (studioId, clientId) = params;

  final messageStream = chatService.streamMessages(studioId, clientId);
  final chatStream =
      chatService.streamSpecificStudio(studioId); // FIXED: Use correct method

  return Rx.combineLatest2<List<MessageModel>, StudioChatModel?,
      ({List<MessageModel> messages, StudioChatModel? chat})>(
    messageStream,
    chatStream,
    (messages, chat) => (messages: messages, chat: chat),
  );
});
