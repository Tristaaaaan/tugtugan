import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../studios/data/model/studio_model.dart';
import '../../studios/presentation/providers/studio_provider.dart';
import '../data/chat_service.dart';
import '../domain/chat_repository.dart';
import '../domain/message_model.dart';
import '../domain/studio_chat_model.dart';
import 'chat_state.dart';

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
