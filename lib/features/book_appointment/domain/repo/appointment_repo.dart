import '../entities/appointment_entity.dart';

abstract class AppointmentRepository {
  Future<void> createAppointment(AppointmentEntity appointmentEntity);
}
