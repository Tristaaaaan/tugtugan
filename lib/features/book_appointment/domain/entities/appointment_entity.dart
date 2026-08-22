import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '../enums/appointment_status_enum.dart';
import 'appointment_slot_entity.dart';

class AppointmentEntity extends Equatable {
  final String? id;
  final String studioId;
  final String customerId;
  final List<AppointmentSlotEntity> slots;
  final List<String>? studioImage;
  final String? studioName;
  // Backend-generated
  final int? appoinmentDate;
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
    this.appoinmentDate,
    this.studioImage,
    this.studioName,
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
        appoinmentDate,
        studioImage,
        studioName
      ];

  String get appoinmentMonth => DateFormat('MMMM').format(
        DateTime.fromMillisecondsSinceEpoch(appoinmentDate ?? 0),
      );

  String get appoinmentDay =>
      DateTime.fromMillisecondsSinceEpoch(appoinmentDate ?? 0).day.toString();

  String get appoinmentTime {
    if (slots.isEmpty) return '';

    final timeFormat = DateFormat('h:mm a');

    // Find the earliest slot by startAt
    final earliestSlot = slots.reduce(
      (a, b) => a.startAt < b.startAt ? a : b,
    );

    final startDateTime =
        DateTime.fromMillisecondsSinceEpoch(earliestSlot.startAt);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final slotDate =
        DateTime(startDateTime.year, startDateTime.month, startDateTime.day);

    final formattedTime = timeFormat.format(startDateTime);

    if (slotDate == today) {
      return '$formattedTime Today';
    } else if (slotDate == tomorrow) {
      return '$formattedTime Tomorrow';
    } else {
      return formattedTime;
    }
  }
}
