import 'dart:core';

import 'package:equatable/equatable.dart';

import '../enums/appointment_status_enum.dart';
import 'appointment_slot_entity.dart';

class AppointmentEntity extends Equatable {
  final String? id;
  final String studioId;
  final String customerId;
  final List<AppointmentSlotEntity> slots;

  // Backend-generated
  final String? bookingNumber;
  final BookingStatus? status;
  final int? approvedAt;
  final int? createdAt;
  final int? updatedAt;

  const AppointmentEntity({
    this.id,
    required this.studioId,
    required this.customerId,
    required this.slots,
    this.bookingNumber,
    this.status,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        studioId,
        customerId,
        slots,
        bookingNumber,
        status,
        approvedAt,
        createdAt,
        updatedAt,
      ];
}
