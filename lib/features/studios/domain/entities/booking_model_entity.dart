import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:tugtugan/features/studios/data/model/booking_model.dart';

class BookingModelEntity extends Equatable {
  final String? id;

  final String studioId;
  final String customerId;

  final int startAt;
  final int endAt;

  final String bookingNumber;

  final BookingStatus status;

  final int? approvedAt;

  final int createdAt;
  final int updatedAt;

  const BookingModelEntity({
    this.id,
    required this.studioId,
    required this.customerId,
    required this.startAt,
    required this.endAt,
    required this.bookingNumber,
    required this.status,
    this.approvedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        studioId,
        customerId,
        startAt,
        endAt,
        bookingNumber,
        status,
        approvedAt,
        createdAt,
        updatedAt,
      ];
}
