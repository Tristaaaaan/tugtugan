import 'package:tugtugan/features/studios/domain/usecases/create_appointment_usecase.dart';

abstract class AppointmentRepository {
  Future<void> createAppointment(Appointment bookingModelEntity);
}
