// domain/usecases/create_appointment_result.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugtugan/features/book_appointment/domain/entities/appointment_slot_entity.dart';

part 'time_slots_states.freezed.dart';

@freezed
class TimeSlotsState with _$TimeSlotsState {
  const factory TimeSlotsState.initial() = _Initial;
  const factory TimeSlotsState.loading() = _Loading;
  const factory TimeSlotsState.loaded(
    List<AppointmentSlotEntity> slots,
  ) = _Loaded;
  const factory TimeSlotsState.empty() = _Empty;
  const factory TimeSlotsState.failure(String message) = _Failure;
}
