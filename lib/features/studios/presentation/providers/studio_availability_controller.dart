import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repos/studio_repository.dart';
import 'studio_availability_state.dart';

class StudioAvailabilityController
    extends StateNotifier<StudioAvailabilityState> {
  final StudioInformationRepository _studioInformationRepository;
  final String studioId;

  StudioAvailabilityController(
    this._studioInformationRepository,
    this.studioId,
  ) : super(const StudioAvailabilityState.initial()) {
    getAvailability();
  }

  Future<void> getAvailability({
    DateTime? month,
  }) async {
    state = const StudioAvailabilityState.loading();

    try {
      final selectedMonth = month ?? DateTime.now();

      final availability = await _studioInformationRepository.getAvailability(
        studioId,
        selectedMonth.year,
        selectedMonth.month,
      );

      if (availability == null || availability.isEmpty) {
        state = const StudioAvailabilityState.empty();
      } else {
        state = StudioAvailabilityState.loaded(availability);
      }
    } catch (e) {
      state = StudioAvailabilityState.error(e.toString());
    }
  }

  Future<void> refreshAvailability() async {
    await getAvailability();
  }
}
