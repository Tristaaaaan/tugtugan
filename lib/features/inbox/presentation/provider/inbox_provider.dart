import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../chat/domain/studio_chat_model.dart';
import '../../../chat/presentation/chat_provider.dart';

final inboxProvider =
    StreamProvider.family<List<StudioChatModel>, String>((ref, clientId) {
  final chatService = ref.watch(chatServiceProvider);
  return chatService.streamUserInboxStudio(clientId);
});
