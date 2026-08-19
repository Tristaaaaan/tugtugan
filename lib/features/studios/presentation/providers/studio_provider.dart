import 'package:riverpod/riverpod.dart';

import '../../data/studio_services.dart';
import '../../domain/repos/studio_repository.dart';

final studioServiceProvider = Provider<StudioRepository>((ref) {
  return StudioServices();
});
