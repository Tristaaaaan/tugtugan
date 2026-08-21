import 'dart:developer' as developer;

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/appointment_model.dart';

abstract class AppointmentRemoteDataSource {
  Future<void> createAppointment(AppointmentModel appointment);
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final FirebaseFunctions functions;

  AppointmentRemoteDataSourceImpl({
    FirebaseFunctions? functions,
  }) : functions = functions ?? FirebaseFunctions.instance;

  @override
  Future<void> createAppointment(
    AppointmentModel appointment,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    developer.log('AUTH USER: ${user?.uid}');
    developer.log('AUTH TOKEN: ${await user?.getIdToken()}');

    final callable = functions.httpsCallable(
      'create_appointment',
    );

    developer.log("Payload: ${appointment.toPayload()}");
    await callable.call(
      appointment.toPayload(),
    );
  }
}
