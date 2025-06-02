import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tugtugan/features/studios/presentation/studio_provider.dart';

import '../../../../core/appmodels/studio_model.dart';
import '../../../chat/domain/studio_chat_model.dart';
import '../../../chat/presentation/chat_provider.dart';

final enrichedInboxProvider = StreamProvider.family<
    List<({StudioChatModel chat, StudioModel? studio})>,
    String>((ref, clientId) {
  final chatService = ref.watch(chatServiceProvider);
  final studioService = ref.watch(studioServiceProvider);

  return chatService.streamUserInboxStudio(clientId).switchMap(
    (chatList) {
      if (chatList.isEmpty) return Stream.value([]);

      final studioStreams = chatList.map((chat) {
        return studioService
            .streamSpecificStudio(chat.studioId, clientId)
            .map((studio) => (chat: chat, studio: studio));
      });

      return Rx.combineLatestList(studioStreams);
    },
  );
});
