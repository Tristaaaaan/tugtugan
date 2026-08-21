import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../chat/domain/studio_chat_model.dart';
import '../../chat/presentation/chat_provider.dart';
import '../../studios/data/model/studio_model.dart';
import '../../studios/presentation/providers/studio_provider.dart';
import '../data/chat_service.dart';
import '../domain/inbox_repository.dart';
import '../domain/realtime_inbox_repository.dart';
import 'inbox_state.dart';

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

final inboxServiceProvider = Provider<InboxRepository>((ref) {
  return InboxService();
});

final studioInboxProvider = StreamProvider.family<List<StudioModel>, String>(
  (ref, clientId) {
    final chatService = ref.watch(chatServiceProvider);
    final studioService = ref.watch(studioServiceProvider);

    return chatService.streamUserInboxStudio(clientId).switchMap(
      (chatList) {
        if (chatList.isEmpty) return Stream.value([]);

        final studioStreams = chatList.map((chat) {
          return studioService
              .streamSpecificStudio(chat.studioId, clientId)
              .where((studio) => studio != null)
              .cast<StudioModel>();
        });

        return Rx.combineLatestList(studioStreams);
      },
    );
  },
);

final inboxRepositoryProvider =
    Provider.family<RealTimeInboxRepository, String>(
  (ref, userId) {
    return RealTimeInboxRepository(userId: userId);
  },
);
final realtimeInboxStateProvider =
    ChangeNotifierProvider.family<RealTimeInboxState, String>(
  (ref, userId) {
    final repo = ref.watch(inboxRepositoryProvider(userId));
    return RealTimeInboxState(repo);
  },
);
