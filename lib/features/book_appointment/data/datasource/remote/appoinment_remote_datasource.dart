import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/appointment_model.dart';

abstract class AppointmentRemoteDataSource {
  Future<void> createAppointment(AppointmentModel appointment);
  Future<List<AppointmentModel>> readAppointments(int? lastUpdatedAt,
      {int limit = 10});
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final FirebaseFunctions functions;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
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

  @override
  Future<List<AppointmentModel>> readAppointments(
    int? lastUpdatedAt, {
    int limit = 10,
  }) async {
    developer.log('readAppointments triggered');
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    try {
      var query = FirebaseFirestore.instance
          .collection('appointments')
          .where('customerId', isEqualTo: user.uid)
          .orderBy('updatedAt', descending: true);

      // ✅ Add cursor-based pagination
      if (lastUpdatedAt != null) {
        query = query.startAfter([lastUpdatedAt]);
      }

      final snapshot =
          await query.limit(limit).get(const GetOptions(source: Source.server));

      return snapshot.docs
          .map((doc) => AppointmentModel.fromMap({
                'id': doc.id,
                ...doc.data(),
              }))
          .toList();
    } catch (e, stackTrace) {
      developer.log('Failed to fetch appointments: $e');
      developer.log('$stackTrace');
      return [];
    }
  }
}
