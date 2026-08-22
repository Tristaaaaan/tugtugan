import 'package:tugtugan/features/studios/domain/entities/business_hours_entity.dart';

import '../../data/model/studio_model.dart';
import '../entities/availability_entity.dart';

abstract class StudioRepository {
  Future<void> followStudio(String studioId, String userId);
  Future<void> unfollowStudio(String studioId, String userId);
  Future<void> addStudio(StudioModel studioData);
  Stream<StudioModel?> streamSpecificStudio(String studioId, String clientId);
}

abstract class StudioInformationRepository {
  // Get availability
  Future<List<StudioAvailabilityEntity>?> getAvailability(
    String studioId,
    int year,
    int month,
  );

  Future<BusinessHoursEntity> getBusinessHours(String studioId);
}
