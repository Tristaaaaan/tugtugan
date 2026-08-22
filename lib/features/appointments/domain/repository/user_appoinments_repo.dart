import '../../../book_appointment/domain/entities/appointment_entity.dart';

abstract class UserAppointmentsRepository {
  Future<List<AppointmentEntity>> readAppointments(int? lastUpdatedAt,
      {int limit = 10});
}
