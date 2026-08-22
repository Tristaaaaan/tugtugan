import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/remote/appoinment_remote_datasource.dart';
import '../../data/repo/appointment_repo_impl.dart';
import '../../domain/repo/appointment_repo.dart';
import '../../domain/usecases/create_appointment_usecase.dart';
import 'appointment_controller.dart';
import 'create_appointment_states.dart';

final appointmentRemoteDataSourceProvider =
    Provider<AppointmentRemoteDataSource>((ref) {
  return AppointmentRemoteDataSourceImpl();
});

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  final remoteDataSource = ref.read(appointmentRemoteDataSourceProvider);

  return AppointmentRepoImpl(
    remoteDataSource: remoteDataSource,
  );
});

final createAppointmentUseCaseProvider =
    Provider<CreateAppointmentUseCase>((ref) {
  return CreateAppointmentUseCase(
    appointmentRepository: ref.watch(appointmentRepositoryProvider),
  );
});

final appointmentControllerProvider =
    StateNotifierProvider<AppointmentController, CreateAppointmentState>(
  (ref) => AppointmentController(
    ref.watch(createAppointmentUseCaseProvider),
  ),
);

final selectedDayProvider = StateProvider<DateTime>((ref) => DateTime.now());
