// data/repositories/firebase_appointment_repository.dart
import 'package:cloud_functions/cloud_functions.dart';
import 'package:tugtugan/features/book_appointment/data/datasource/remote/appoinment_remote_datasource.dart';
import 'package:tugtugan/features/book_appointment/data/model/appointment_model.dart';
import 'package:tugtugan/features/book_appointment/domain/entities/appointment_entity.dart';
import 'package:tugtugan/features/book_appointment/domain/usecases/create_appointment_usecase.dart';

import '../../domain/repo/appointment_repo.dart';

class AppointmentRepoImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepoImpl({required this.remoteDataSource});

  @override
  Future<void> createAppointment(AppointmentEntity appointment) async {
    try {
      final model = AppointmentModel.fromEntity(appointment);
      await remoteDataSource.createAppointment(model);
    } on FirebaseFunctionsException catch (e) {
      throw AppointmentException(e.code, e.message ?? 'Something went wrong');
    } catch (e) {
      throw AppointmentException('unknown', 'Unexpected error occurred');
    }
  }
}
