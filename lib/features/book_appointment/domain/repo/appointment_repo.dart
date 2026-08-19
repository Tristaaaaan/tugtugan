import 'package:tugtugan/features/studios/domain/entities/booking_model_entity.dart';

abstract class AppointmentRepository {
  Future<void> createAppointment(BookingModelEntity bookingModelEntity);
}
