import '../entities/appointment_slot_entity.dart';

abstract class AppointmentSlotRepository {
  Future<List<AppointmentSlotEntity>> getSlots(String studioId);
}
