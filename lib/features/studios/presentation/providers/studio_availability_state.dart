import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/availability_entity.dart';

part 'studio_availability_state.freezed.dart';

@freezed
class StudioAvailabilityState with _$StudioAvailabilityState {
  const factory StudioAvailabilityState.initial() = _Initial;
  const factory StudioAvailabilityState.loading() = _Loading;
  const factory StudioAvailabilityState.loaded(
    List<StudioAvailabilityEntity> studioAvailability,
  ) = _Loaded;
  const factory StudioAvailabilityState.error(String message) = _Failure;
}
