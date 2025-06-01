import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tugtugan/features/studios/data/studio_services.dart';
import 'package:tugtugan/features/studios/domain/chat_repository.dart';

final studioServiceProvider = Provider<StudioRepository>((ref) {
  return StudioServices();
});
