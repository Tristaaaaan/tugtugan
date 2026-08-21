import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/appointment_slot_entity.dart';

part 'appointment_slot_model.freezed.dart';

@freezed
abstract class AppointmentSlotModel with _$AppointmentSlotModel {
  const factory AppointmentSlotModel({
    required int startAt,
    required int endAt,
  }) = _AppointmentSlotModel;

  const AppointmentSlotModel._();

  factory AppointmentSlotModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppointmentSlotModel(
      startAt: map['startAt'] as int,
      endAt: map['endAt'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startAt': startAt,
      'endAt': endAt,
    };
  }

  AppointmentSlotEntity toEntity() {
    return AppointmentSlotEntity(
      startAt: startAt,
      endAt: endAt,
    );
  }

  factory AppointmentSlotModel.fromEntity(
    AppointmentSlotEntity entity,
  ) {
    return AppointmentSlotModel(
      startAt: entity.startAt,
      endAt: entity.endAt,
    );
  }

  Map<String, dynamic> toPayload() {
    return {
      'startAt': startAt,
      'endAt': endAt,
    };
  }
}
