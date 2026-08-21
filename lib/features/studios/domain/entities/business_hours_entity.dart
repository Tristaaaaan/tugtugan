import 'package:equatable/equatable.dart';

import '../../../book_appointment/domain/enums/weekday_enum.dart';

class BusinessHoursEntity extends Equatable {
  final List<Weekday> days;
  final int openAt;
  final int closeAt;
  final int slotDuration;

  const BusinessHoursEntity({
    required this.days,
    required this.openAt,
    required this.closeAt,
    required this.slotDuration,
  });

  @override
  List<Object?> get props => [
        days,
        openAt,
        closeAt,
        slotDuration,
      ];
}
