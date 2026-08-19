// data/repositories/firebase_appointment_repository.dart
import 'package:cloud_functions/cloud_functions.dart';
import 'package:tugtugan/features/studios/domain/usecases/create_appointment_usecase.dart';

import '../../domain/repo/appointment_repo.dart';

class AppointmentRepoImpl implements AppointmentRepository {
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  @override
  Future<void> createAppointment(Appointment appointment) async {
    try {
      final callable =
          FirebaseFunctions.instance.httpsCallable('create_appointment');
      // or FirebaseFunctions.instanceFor(region: 'your-region') if not us-central1
      await callable.call(appointment.toPayload());
    } on FirebaseFunctionsException catch (e) {
      throw AppointmentException(e.code, e.message ?? 'Something went wrong');
    } catch (e) {
      throw AppointmentException('unknown', 'Unexpected error occurred');
    }
  }
}
