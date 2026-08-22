import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import '../../../book_appointment/domain/entities/appointment_slot_entity.dart';
import '../../data/model/studio_model.dart';
import '../../domain/entities/studio_entity.dart';

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
    StreamProvider.family<StudioEntity, String>((ref, studioId) {
  return FirebaseFirestore.instance
      .collection("studios")
      .doc(studioId)
      .snapshots()
      .map(
        (querySnapshot) => StudioModel.fromSnapshot(querySnapshot).toEntity(),
      );
});

// Class
class AppointmentSelection {
  final List<AppointmentSlotEntity> slots;

  const AppointmentSelection({
    this.slots = const [],
  });

  AppointmentSelection copyWith({
    List<AppointmentSlotEntity>? slots,
  }) {
    return AppointmentSelection(
      slots: slots ?? this.slots,
    );
  }
}

class AppointmentSelectionNotifier extends Notifier<AppointmentSelection> {
  @override
  AppointmentSelection build() {
    return const AppointmentSelection();
  }

  /// Toggle a time slot on/off
  void toggleSlot(AppointmentSlotEntity slot) {
    final isSelected = isSlotSelected(slot);
    if (isSelected) {
      // Remove the slot
      state = state.copyWith(
        slots:
            state.slots.where((item) => item.startAt != slot.startAt).toList(),
      );
    } else {
      // Add the slot
      state = state.copyWith(
        slots: [
          ...state.slots,
          slot,
        ],
      );
    }
  }

  /// Check if a slot is currently selected
  bool isSlotSelected(AppointmentSlotEntity slot) {
    return state.slots.any((item) => item.startAt == slot.startAt);
  }

  /// Clear everything (date and slots)
  void clear() {
    state = const AppointmentSelection();
  }
}

final appointmentSelectionProvider =
    NotifierProvider<AppointmentSelectionNotifier, AppointmentSelection>(
  AppointmentSelectionNotifier.new,
);
