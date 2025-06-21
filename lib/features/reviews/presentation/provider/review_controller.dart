// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jogaliga_frontend/features/team_manager_profile/domain/manager_profile_repository.dart';

// import '../../../data/manager_profile_repo_impl.dart';
// import 'review_state.dart';

// final managerProfileControllerProvider =
//     StateNotifierProvider<ManageProfileController, ManagerProfileState>(
//   (ref) => ManageProfileController(
//     ref.watch(managerProfileRepositoryProvider),
//   ),
// );

// class ManageProfileController extends StateNotifier<ManagerProfileState> {
//   final ManagerProfileRepository _managerProfileRepository;

//   ManageProfileController(this._managerProfileRepository)
//       : super(const ManagerProfileState.initial()) {
//     managerProfileData();
//   }

//   Future<void> managerProfileData() async {
//     state = const ManagerProfileState.loading();

//     try {
//       final managerProfileData =
//           await _managerProfileRepository.getManagerProfileData();

//       if (managerProfileData == null) {
//         state = const ManagerProfileState.empty();
//         return;
//       }

//       state = ManagerProfileState.loaded(
//         managerProfile: managerProfileData.managerProfile,
//       );
//     } catch (e) {
//       state = ManagerProfileState.error(e.toString());
//     }
//   }

//   Future<void> refreshDashboard() async {
//     await managerProfileData();
//   }
// }
