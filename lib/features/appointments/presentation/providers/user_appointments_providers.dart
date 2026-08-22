import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/appointments/data/repository/user_appoinments_repo_impl.dart';
import 'package:tugtugan/features/appointments/domain/repository/user_appoinments_repo.dart';
import 'package:tugtugan/features/appointments/presentation/providers/user_appointments_controller.dart';
import 'package:tugtugan/features/appointments/presentation/providers/user_appointments_states.dart';
import 'package:tugtugan/features/book_appointment/presentation/providers/appointment_providers.dart';

// Top Selection Bar Provider - Active / Past Appointments
final isActiveAppoinmentTabProvider = StateProvider<bool>((ref) => true);

// ✅ Repository Provider
final userAppointmentsRepositoryProvider = Provider<UserAppointmentsRepository>(
  (ref) {
    return UserAppoinmentsRepoImpl(
      appointmentRemoteDataSource:
          ref.watch(appointmentRemoteDataSourceProvider),
    );
  },
);

// ✅ Controller Provider
final userAppointmentsControllerProvider =
    StateNotifierProvider<UserAppointmentsController, UserAppointmentsStates>(
  (ref) {
    final repository = ref.watch(userAppointmentsRepositoryProvider);
    return UserAppointmentsController(repository);
  },
);

// ✅ Optional: Helper provider to get appointments list
final userAppointmentsProvider =
    StateNotifierProvider<UserAppointmentsController, UserAppointmentsStates>(
  (ref) {
    final repository = ref.watch(userAppointmentsRepositoryProvider);
    return UserAppointmentsController(repository);
  },
);
