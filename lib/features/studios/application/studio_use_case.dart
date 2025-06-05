import 'package:tugtugan/features/studios/domain/studio_repository.dart';

class StudioUseCase {
  final StudioRepository repository;

  StudioUseCase(this.repository);

  Future<void> execute(
    bool isFollowing,
    String studioId,
    String clientId,
  ) async {
    if (isFollowing) {
      await repository.unfollowStudio(studioId, clientId);
    } else {
      await repository.followStudio(studioId, clientId);
    }
  }
}
