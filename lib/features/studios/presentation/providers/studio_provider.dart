import 'package:riverpod/riverpod.dart';
import 'package:tugtugan/features/studios/data/studio_services.dart';
import 'package:tugtugan/features/studios/domain/studio_repository.dart';

final studioServiceProvider = Provider<StudioRepository>((ref) {
  return StudioServices();
});
