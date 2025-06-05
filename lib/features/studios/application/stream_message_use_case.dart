import 'package:tugtugan/core/appmodels/studio_model.dart';
import 'package:tugtugan/features/studios/domain/studio_repository.dart';

class StreamStudioUseCase {
  final StudioRepository repository;

  StreamStudioUseCase(this.repository);

  Stream<StudioModel?> call(String studioId, String clientId) {
    return repository.streamSpecificStudio(studioId, clientId);
  }
}
