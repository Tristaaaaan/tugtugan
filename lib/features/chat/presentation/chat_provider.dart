import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tugtugan/core/appmodels/studio_model.dart';
import 'package:tugtugan/features/chat/data/chat_service.dart';
import 'package:tugtugan/features/chat/domain/chat_repository.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';
import 'package:tugtugan/features/chat/presentation/chat_state.dart';
import 'package:tugtugan/features/studios/presentation/studio_provider.dart';

import '../domain/studio_chat_model.dart';

final chatServiceProvider = Provider<ChatRepository>((ref) {
  return ChatService();
});

final combinedChatProvider = StreamProvider.family<
    ({List<MessageModel> messages, StudioChatModel? chat, StudioModel? studio}),
    (String studioId, String clientId)>((ref, params) {
  final chatService = ref.watch(chatServiceProvider);
  final studioService = ref.watch(studioServiceProvider);
  final (studioId, clientId) = params;

  final messageStream = chatService.streamMessages(studioId, clientId);
  final chatStream = chatService.streamSpecificStudio(studioId, clientId);
  final studioStream = studioService.streamSpecificStudio(studioId, clientId);

  return Rx.combineLatest3<
      List<MessageModel>,
      StudioChatModel?,
      StudioModel?,
      ({
        List<MessageModel> messages,
        StudioChatModel? chat,
        StudioModel? studio
      })>(
    messageStream,
    chatStream,
    studioStream,
    (messages, chat, studio) => (
      messages: messages,
      chat: chat,
      studio: studio,
    ),
  );
});

final chatTestRepositoryProvider =
    Provider.family<RealTimeChatRepository, (String studioId, String clientId)>(
  (ref, args) {
    final (studioId, clientId) = args;
    return RealTimeChatRepository(studioId: studioId, clientId: clientId);
  },
);

final realtimeChatStateProvider = ChangeNotifierProvider.family<
    RealTimeChatState, (String studioId, String clientId)>(
  (ref, args) {
    final repo = ref.watch(chatTestRepositoryProvider(args));
    return RealTimeChatState(repo);
  },
);
