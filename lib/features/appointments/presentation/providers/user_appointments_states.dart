import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../book_appointment/domain/entities/appointment_entity.dart';

part 'user_appointments_states.freezed.dart';

@freezed
class UserAppointmentsStates with _$UserAppointmentsStates {
  const factory UserAppointmentsStates.initial() = _Initial;
  const factory UserAppointmentsStates.loading() = _Loading;
  const factory UserAppointmentsStates.loaded(
    List<AppointmentEntity>? appointment,
    bool hasMore,
  ) = _Loaded;
  const factory UserAppointmentsStates.error(String message) = _Error;
  const factory UserAppointmentsStates.empty() = _Empty;
}
