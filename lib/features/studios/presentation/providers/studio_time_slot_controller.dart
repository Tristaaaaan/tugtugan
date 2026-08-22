import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/studios/domain/repos/studio_repository.dart';
import 'package:tugtugan/features/studios/presentation/providers/studio_time_slot_state.dart';

class StudioTimeSlotController extends StateNotifier<StudioTimeSlotState> {
  final StudioInformationRepository _studioInformationRepository;
  final String studioId;

  StudioTimeSlotController(
    this._studioInformationRepository,
    this.studioId,
  ) : super(const StudioTimeSlotState.initial()) {
    getTimeSlots();
  }

  Future<void> getTimeSlots({
    DateTime? month,
  }) async {
    state = const StudioTimeSlotState.loading();

    try {
      final businessHours = await _studioInformationRepository.getBusinessHours(
        studioId,
      );
      state = StudioTimeSlotState.loaded(businessHours);
    } catch (e) {
      state = StudioTimeSlotState.error(e.toString());
    }
  }

  Future<void> refreshTimeSlots() async {
    await getTimeSlots();
  }
}
