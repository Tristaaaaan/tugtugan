import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import '../../../book_appointment/domain/entities/appointment_slot_entity.dart';
import '../../data/model/studio_model.dart';

final studioProvider = StreamProvider<List<StudioModel>>((ref) {
  return FirebaseFirestore.instance
      .collection("studios")
      .limit(10)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
          .map((doc) => StudioModel.fromSnapshot(doc))
          .toList());
});

final specificStudioProvider =
    StreamProvider.family<StudioModel, String>((ref, studioId) {
  return FirebaseFirestore.instance
      .collection("studios")
      .doc(studioId)
      .snapshots()
      .map(
        (querySnapshot) => StudioModel.fromSnapshot(querySnapshot),
      );
});

class AppointmentSelection {
  final DateTime? date;
  final List<AppointmentSlotEntity> slots;

  const AppointmentSelection({
    this.date,
    this.slots = const [],
  });

  AppointmentSelection copyWith({
    DateTime? date,
    List<AppointmentSlotEntity>? slots,
  }) {
    return AppointmentSelection(
      date: date ?? this.date,
      slots: slots ?? this.slots,
    );
  }
}

class AppointmentSelectionNotifier extends Notifier<AppointmentSelection> {
  @override
  AppointmentSelection build() {
    return const AppointmentSelection();
  }

  void selectDate(DateTime date) {
    state = AppointmentSelection(
      date: date,
      slots: [],
    );
  }

  void toggleSlot(AppointmentSlotEntity slot) {
    if (state.date == null) return;

    final exists = state.slots.contains(slot);

    if (exists) {
      state = state.copyWith(
        slots: state.slots.where((item) => item != slot).toList(),
      );
    } else {
      state = state.copyWith(
        slots: [
          ...state.slots,
          slot,
        ],
      );
    }
  }

  void clearSlots() {
    state = state.copyWith(
      slots: [],
    );
  }

  void clear() {
    state = const AppointmentSelection();
  }
}

final appointmentSelectionProvider =
    NotifierProvider<AppointmentSelectionNotifier, AppointmentSelection>(
  AppointmentSelectionNotifier.new,
);
