// import 'dart:developer' as developer;

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tugtugan/features/book_appointment/domain/entities/appointment_slot_entity.dart';
// import 'package:tugtugan/features/book_appointment/presentation/providers/time_slots_states.dart';

// class TimeSlotsController extends StateNotifier<TimeSlotsState> {
//   TimeSlotsController(this._createAppointmentUseCase)
//       : super(const TimeSlotsState.initial());

//   final CreateAppointmentUseCase _createAppointmentUseCase;

//   /// 🔹 Create a new appointment
//   Future<void> getTimeSlots(AppointmentSlotEntity appointment) async {
//     state = const TimeSlotsState.loading();

//     try {} catch (e) {
//       developer.log('createAppointment threw — $e');
//     }
//   }

//   /// 🔹 Reset back to initial state
//   void reset() {}
// }
