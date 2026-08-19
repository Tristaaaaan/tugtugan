// domain/usecases/create_appointment_usecase.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tugtugan/features/book_appointment/domain/repo/appointment_repo.dart';

class CreateAppointmentUseCase {
  final AppointmentRepository appointmentRepository;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CreateAppointmentUseCase({
    required this.appointmentRepository,
  });

  Future<CreateAppointmentResult> call(Appointment appointment) async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      return CreateAppointmentResult.notSignedIn();
    }

    try {
      await user.getIdToken(true);
      await appointmentRepository.createAppointment(appointment);
      return CreateAppointmentResult.success();
    } on AppointmentException catch (e) {
      return CreateAppointmentResult.failure(e.message);
    }
  }
}

// domain/entities/appointment.dart
class Appointment {
  final DateTime date;

  const Appointment({required this.date});

  Map<String, dynamic> toPayload() => {
        'date': date.toIso8601String().split('T').first, // 'yyyy-MM-dd'
      };
}

// domain/usecases/create_appointment_result.dart
class CreateAppointmentResult {
  final bool success;
  final bool needsSignIn;
  final String? errorMessage;

  const CreateAppointmentResult._({
    required this.success,
    required this.needsSignIn,
    this.errorMessage,
  });

  factory CreateAppointmentResult.success() =>
      const CreateAppointmentResult._(success: true, needsSignIn: false);

  factory CreateAppointmentResult.notSignedIn() =>
      const CreateAppointmentResult._(success: false, needsSignIn: true);

  factory CreateAppointmentResult.failure(String message) =>
      CreateAppointmentResult._(
        success: false,
        needsSignIn: false,
        errorMessage: message,
      );
}

// domain/exceptions/appointment_exception.dart
class AppointmentException implements Exception {
  final String code;
  final String message;
  AppointmentException(this.code, this.message);
}
