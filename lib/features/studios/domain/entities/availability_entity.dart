import 'package:equatable/equatable.dart';

class StudioAvailabilityEntity extends Equatable {
  final int date;
  final bool isClosed;
  final String? description;

  const StudioAvailabilityEntity({
    required this.date,
    required this.isClosed,
    this.description,
  });

  @override
  List<Object?> get props => [
        date,
        isClosed,
        description,
      ];
}
