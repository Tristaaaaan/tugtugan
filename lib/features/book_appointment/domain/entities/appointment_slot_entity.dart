import 'package:equatable/equatable.dart';

class AppointmentSlotEntity extends Equatable {
  final int startAt;
  final int endAt;

  const AppointmentSlotEntity({
    required this.startAt,
    required this.endAt,
  });

  @override
  List<Object?> get props => [
        startAt,
        endAt,
      ];
}
