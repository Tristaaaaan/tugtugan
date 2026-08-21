import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../book_appointment/domain/enums/weekday_enum.dart';
import '../../domain/entities/business_hours_entity.dart';

part 'business_hours_model.freezed.dart';

@freezed
abstract class BusinessHoursModel with _$BusinessHoursModel {
  const factory BusinessHoursModel({
    required List<Weekday> days,
    required int openAt,
    required int closeAt,
    required int slotDuration,
  }) = _BusinessHoursModel;

  const BusinessHoursModel._();

  factory BusinessHoursModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return BusinessHoursModel(
      days: (map['days'] as List<dynamic>)
          .map(
            (day) => Weekday.values.byName(day as String),
          )
          .toList(),
      openAt: map['openAt'] as int,
      closeAt: map['closeAt'] as int,
      slotDuration: map['slotDuration'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'days': days.map((day) => day.name).toList(),
      'openAt': openAt,
      'closeAt': closeAt,
      'slotDuration': slotDuration,
    };
  }

  BusinessHoursEntity toEntity() {
    return BusinessHoursEntity(
      days: days,
      openAt: openAt,
      closeAt: closeAt,
      slotDuration: slotDuration,
    );
  }

  factory BusinessHoursModel.fromEntity(
    BusinessHoursEntity entity,
  ) {
    return BusinessHoursModel(
      days: entity.days,
      openAt: entity.openAt,
      closeAt: entity.closeAt,
      slotDuration: entity.slotDuration,
    );
  }
}
