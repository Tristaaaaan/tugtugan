import '../../../core/appmodels/studio_model.dart';

abstract class StudioRepository {
  Future<void> followStudio(String studioId, String userId);
  Future<void> unfollowStudio(String studioId, String userId);
  Future<void> addStudio(StudioModel studioData);
  Stream<StudioModel?> streamSpecificStudio(String studioId, String clientId);
}
