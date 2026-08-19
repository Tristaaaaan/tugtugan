// domain/usecases/create_appointment_result.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_appointment_states.freezed.dart';

@freezed
class CreateAppointmentState with _$CreateAppointmentState {
  const factory CreateAppointmentState.initial() = _Initial;
  const factory CreateAppointmentState.loading() = _Loading;
  const factory CreateAppointmentState.success() = _Success;
  const factory CreateAppointmentState.needsSignIn() = _NeedsSignIn;
  const factory CreateAppointmentState.failure(String message) = _Failure;
}
