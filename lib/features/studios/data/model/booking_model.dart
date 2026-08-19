import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugtugan/features/studios/domain/entities/booking_model_entity.dart';

part 'booking_model.freezed.dart';

@freezed
abstract class BookingModel with _$BookingModel {
  const factory BookingModel({
    String? id,
    required String studioId,
    required String customerId,
    required DateTime startAt,
    required DateTime endAt,
    required String bookingNumber,
    required BookingStatus status,
    DateTime? approvedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BookingModel;

  const BookingModel._();

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as String?,
      studioId: map['studioId'] as String,
      customerId: map['customerId'] as String,
      startAt: DateTime.fromMillisecondsSinceEpoch(
        map['startAt'] as int,
      ),
      endAt: DateTime.fromMillisecondsSinceEpoch(
        map['endAt'] as int,
      ),
      bookingNumber: map['bookingNumber'] as String,
      status: BookingStatus.values.byName(
        map['status'] as String,
      ),
      approvedAt: map['approvedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['approvedAt'] as int,
            )
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] as int,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'] as int,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studioId': studioId,
      'customerId': customerId,
      'startAt': startAt.millisecondsSinceEpoch,
      'endAt': endAt.millisecondsSinceEpoch,
      'bookingNumber': bookingNumber,
      'status': status.name,
      'approvedAt': approvedAt?.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  BookingModelEntity toEntity() {
    return BookingModelEntity(
      id: id,
      studioId: studioId,
      customerId: customerId,
      startAt: startAt.millisecondsSinceEpoch,
      endAt: endAt.millisecondsSinceEpoch,
      bookingNumber: bookingNumber,
      status: status,
      approvedAt: approvedAt?.millisecondsSinceEpoch,
      createdAt: createdAt.millisecondsSinceEpoch,
      updatedAt: updatedAt.millisecondsSinceEpoch,
    );
  }

  factory BookingModel.fromEntity(BookingModelEntity entity) {
    return BookingModel(
      id: entity.id,
      studioId: entity.studioId,
      customerId: entity.customerId,
      startAt: DateTime.fromMillisecondsSinceEpoch(entity.startAt),
      endAt: DateTime.fromMillisecondsSinceEpoch(entity.endAt),
      bookingNumber: entity.bookingNumber,
      status: entity.status,
      approvedAt: entity.approvedAt != null
          ? DateTime.fromMillisecondsSinceEpoch(entity.approvedAt!)
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(entity.createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(entity.updatedAt),
    );
  }
}

enum BookingStatus {
  pending,
  approved,
  rejected,
  cancelled,
  completed,
}
