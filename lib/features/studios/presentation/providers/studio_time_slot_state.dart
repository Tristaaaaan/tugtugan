import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/business_hours_entity.dart';

part 'studio_time_slot_state.freezed.dart';

@freezed
class StudioTimeSlotState with _$StudioTimeSlotState {
  const factory StudioTimeSlotState.initial() = _Initial;
  const factory StudioTimeSlotState.loading() = _Loading;
  const factory StudioTimeSlotState.loaded(
    BusinessHoursEntity studioAvailability,
  ) = _Loaded;
  const factory StudioTimeSlotState.empty() = _Empty;
  const factory StudioTimeSlotState.error(String message) = _Failure;
}
