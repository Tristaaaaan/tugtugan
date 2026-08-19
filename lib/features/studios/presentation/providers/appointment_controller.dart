import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/book_appointment/presentation/providers/create_appointment_states.dart';
import 'package:tugtugan/features/studios/domain/usecases/create_appointment_usecase.dart';

class AppointmentController extends StateNotifier<CreateAppointmentState> {
  AppointmentController(this._createAppointmentUseCase)
      : super(const CreateAppointmentState.initial());

  final CreateAppointmentUseCase _createAppointmentUseCase;

  bool _isLoading = false;

  /// 🔹 Create a new appointment
  Future<void> createAppointment(Appointment appointment) async {
    if (_isLoading) {
      developer.log('createAppointment skipped — already in progress');
      return;
    }

    _isLoading = true;
    state = const CreateAppointmentState.loading();

    try {
      final result = await _createAppointmentUseCase(appointment);

      if (result.needsSignIn) {
        developer.log('createAppointment failed — user not signed in');
        state = const CreateAppointmentState.needsSignIn();
      } else if (result.success) {
        developer.log('Appointment created successfully');
        state = const CreateAppointmentState.success();
      } else {
        developer.log('createAppointment failed — ${result.errorMessage}');
        state = CreateAppointmentState.failure(
          result.errorMessage ?? 'Something went wrong. Please try again.',
        );
      }
    } catch (e) {
      developer.log('createAppointment threw — $e');
      state = CreateAppointmentState.failure(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  /// 🔹 Reset back to initial state
  void reset() {
    if (_isLoading) return;
    state = const CreateAppointmentState.initial();
  }
}
