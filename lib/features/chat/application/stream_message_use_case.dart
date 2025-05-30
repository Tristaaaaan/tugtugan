import 'package:tugtugan/features/chat/domain/chat_repository.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';

class StreamMessagesUseCase {
  final ChatRepository repository;

  StreamMessagesUseCase(this.repository);

  Stream<List<MessageModel>> call(String studioId, String clientId) {
    return repository.streamMessages(studioId, clientId);
  }
}
