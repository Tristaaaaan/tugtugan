import 'package:cloud_functions/cloud_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tugtugan/features/studios/presentation/providers/studio_time_slot_controller.dart';
import 'package:tugtugan/features/studios/presentation/providers/studio_time_slot_state.dart';

import '../../data/datasource/remote/studio_information_remote_datasource.dart';
import '../../data/repository/studio_repo_impl.dart';
import '../../domain/repos/studio_repository.dart';
import 'studio_availability_controller.dart';
import 'studio_availability_state.dart';

final studioServiceProvider = Provider<StudioRepository>((ref) {
  return StudioServices();
});

final studioInformationRepositoryProvider =
    Provider<StudioInformationRepository>((ref) {
  final remoteDatasource = ref.watch(
    studioInformationRemoteDatasourceProvider,
  );

  return StudioInformationRepositoryImpl(
    studioInformationRemoteDatasource: remoteDatasource,
  );
});

class GetStudioAvailabilityParams extends Equatable {
  final String studioId;
  final int month;
  final int year;

  const GetStudioAvailabilityParams({
    required this.studioId,
    required this.month,
    required this.year,
  });

  @override
  List<Object?> get props => [studioId, month, year];
}

final studioInformationRemoteDatasourceProvider =
    Provider<StudioInformationRemoteDatasource>((ref) {
  return StudioInformationRemoteDatasourceImpl(
    functions: FirebaseFunctions.instance,
  );
});

final studioAvailabilityControllerProvider = StateNotifierProvider.family<
    StudioAvailabilityController,
    StudioAvailabilityState,
    GetStudioAvailabilityParams>(
  (ref, availabilityParams) {
    final repository = ref.watch(
      studioInformationRepositoryProvider,
    );

    return StudioAvailabilityController(
      repository,
      availabilityParams.studioId,
      availabilityParams.month,
      availabilityParams.year,
    );
  },
);

final studioTimeSlotControllerProvider = StateNotifierProvider.family<
    StudioTimeSlotController, StudioTimeSlotState, String>(
  (ref, studioId) {
    final repository = ref.watch(
      studioInformationRepositoryProvider,
    );

    return StudioTimeSlotController(
      repository,
      studioId,
    );
  },
);
