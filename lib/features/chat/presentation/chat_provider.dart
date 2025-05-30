import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/chat/application/stream_message_use_case.dart';
import 'package:tugtugan/features/chat/data/chat_service.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';

final streamMessagesUseCaseProvider = Provider(
  (ref) => StreamMessagesUseCase(ChatService()),
);

final chatMessagesStreamProvider =
    StreamProvider.family<List<MessageModel>, (String, String)>((ref, tuple) {
  final (studioId, clientId) = tuple;
  final useCase = ref.watch(streamMessagesUseCaseProvider);
  return useCase(studioId, clientId);
});
