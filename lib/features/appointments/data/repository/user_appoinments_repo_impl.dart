import 'dart:developer' as developer;

import '../../../book_appointment/data/datasource/remote/appoinment_remote_datasource.dart';
import '../../../book_appointment/domain/entities/appointment_entity.dart';
import '../../domain/repository/user_appoinments_repo.dart';

class UserAppoinmentsRepoImpl implements UserAppointmentsRepository {
  final AppointmentRemoteDataSource _appointmentRemoteDataSource;

  UserAppoinmentsRepoImpl({
    required AppointmentRemoteDataSource appointmentRemoteDataSource,
  }) : _appointmentRemoteDataSource = appointmentRemoteDataSource;

  @override
  Future<List<AppointmentEntity>> readAppointments(int? lastUpdatedAt,
      {int limit = 10}) async {
    developer.log('readAppointments triggered');
    final draws = await _appointmentRemoteDataSource.readAppointments(
      lastUpdatedAt,
      limit: limit,
    );

    return draws.map((draw) => draw.toEntity()).toList();
  }
}
