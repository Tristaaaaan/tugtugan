import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/availability_entity.dart';

part 'availability_model.freezed.dart';

@freezed
abstract class AvailabilityModel with _$AvailabilityModel {
  const factory AvailabilityModel({
    required int date,
    required bool isClosed,
    String? description,
  }) = _AvailabilityModel;

  const AvailabilityModel._();

  factory AvailabilityModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AvailabilityModel(
      date: map['date'] as int,
      isClosed: map['isClosed'] as bool,
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'isClosed': isClosed,
      'description': description,
    };
  }

  StudioAvailabilityEntity toEntity() {
    return StudioAvailabilityEntity(
      date: date,
      isClosed: isClosed,
      description: description,
    );
  }

  factory AvailabilityModel.fromEntity(
    StudioAvailabilityEntity entity,
  ) {
    return AvailabilityModel(
      date: entity.date,
      isClosed: entity.isClosed,
      description: entity.description,
    );
  }
}
