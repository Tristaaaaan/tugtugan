import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/appointment_entity.dart';
import '../../domain/enums/appointment_status_enum.dart';
import 'appointment_slot_model.dart';

part 'appointment_model.freezed.dart';

@freezed
abstract class AppointmentModel with _$AppointmentModel {
  const factory AppointmentModel({
    String? id,
    required String studioId,
    required String customerId,
    required List<AppointmentSlotModel> slots,
    String? bookingNumber,
    BookingStatus? status,
    int? approvedAt,
    int? createdAt,
    int? updatedAt,
  }) = _AppointmentModel;

  const AppointmentModel._();

  factory AppointmentModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AppointmentModel(
      id: map['id'] as String?,
      studioId: map['studioId'] as String,
      customerId: map['customerId'] as String,
      slots: (map['slots'] as List<dynamic>)
          .map(
            (slot) => AppointmentSlotModel.fromMap(
              Map<String, dynamic>.from(slot as Map),
            ),
          )
          .toList(),
      bookingNumber: map['bookingNumber'] as String?,
      status: map['status'] != null
          ? BookingStatus.values.byName(
              map['status'] as String,
            )
          : null,
      approvedAt: map['approvedAt'] as int?,
      createdAt: map['createdAt'] as int?,
      updatedAt: map['updatedAt'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studioId': studioId,
      'customerId': customerId,
      'slots': slots.map((slot) => slot.toMap()).toList(),
      'bookingNumber': bookingNumber,
      'status': status,
      'approvedAt': approvedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  AppointmentEntity toEntity() {
    return AppointmentEntity(
      id: id,
      studioId: studioId,
      customerId: customerId,
      slots: slots.map((slot) => slot.toEntity()).toList(),
      bookingNumber: bookingNumber,
      status: status,
      approvedAt: approvedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory AppointmentModel.fromEntity(
    AppointmentEntity entity,
  ) {
    return AppointmentModel(
      id: entity.id,
      studioId: entity.studioId,
      customerId: entity.customerId,
      slots: entity.slots
          .map(
            (slot) => AppointmentSlotModel.fromEntity(slot),
          )
          .toList(),
      bookingNumber: entity.bookingNumber,
      status: entity.status,
      approvedAt: entity.approvedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toPayload() {
    return {
      'studioId': studioId,
      'customerId': customerId,
      'slots': slots
          .map(
            (slot) => slot.toPayload(),
          )
          .toList(),
    };
  }
}
