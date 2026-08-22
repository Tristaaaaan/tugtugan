import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repos/studio_repository.dart';
import 'studio_availability_state.dart';

class StudioAvailabilityController
    extends StateNotifier<StudioAvailabilityState> {
  final StudioInformationRepository _studioInformationRepository;
  final String studioId;
  final int month;
  final int year;

  StudioAvailabilityController(
    this._studioInformationRepository,
    this.studioId,
    this.month,
    this.year,
  ) : super(const StudioAvailabilityState.initial()) {
    getAvailability();
  }

  Future<void> getAvailability() async {
    state = const StudioAvailabilityState.loading();

    try {
      // ✅ Use constructor properties this.year and this.month
      final availability = await _studioInformationRepository.getAvailability(
        studioId,
        year,
        month,
      );
      developer.log('Availability: $availability');
      state = StudioAvailabilityState.loaded(availability ?? []);
    } catch (e) {
      state = StudioAvailabilityState.error(e.toString());
    }
  }

  Future<void> refreshAvailability() async {
    await getAvailability();
  }
}
