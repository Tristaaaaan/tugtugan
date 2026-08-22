import 'package:equatable/equatable.dart';

import '../../../book_appointment/domain/entities/appointment_slot_entity.dart';
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
  List<AppointmentSlotEntity> generateSlotsForDay(DateTime date) {
    final slots = <AppointmentSlotEntity>[];

    final openDateTime = DateTime.fromMillisecondsSinceEpoch(openAt);
    final closeDateTime = DateTime.fromMillisecondsSinceEpoch(closeAt);

    for (DateTime current = openDateTime;
        current.isBefore(closeDateTime);
        current = current.add(Duration(minutes: slotDuration))) {
      final endTime = current.add(Duration(minutes: slotDuration));

      slots.add(
        AppointmentSlotEntity(
          startAt: current.millisecondsSinceEpoch,
          endAt: endTime.millisecondsSinceEpoch,
        ),
      );
    }

    return slots;
  }

  List<AppointmentSlotEntity> get appointmentSlots {
    return generateSlotsForDay(DateTime.now());
  }

  @override
  List<Object?> get props => [
        days,
        openAt,
        closeAt,
        slotDuration,
      ];
}
