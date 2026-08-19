import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/book_appointment/data/repo/appointment_repo_impl.dart';
import 'package:tugtugan/features/book_appointment/domain/repo/appointment_repo.dart';
import 'package:tugtugan/features/book_appointment/presentation/providers/create_appointment_states.dart';
import 'package:tugtugan/features/studios/domain/usecases/create_appointment_usecase.dart';
import 'package:tugtugan/features/studios/presentation/providers/appointment_controller.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  return AppointmentRepoImpl();
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
