import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/review_repository_impl.dart';
import '../../domain/review_repository.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryImpl();
});
