import 'package:riverpod/riverpod.dart';

import '../../data/review_repository_impl.dart';
import '../../domain/review_repository.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryImpl();
});

final experienceRatingProvider = StateProvider<int>((ref) => 0);
final instrumentRatingProvider = StateProvider<int>((ref) => 0);
final wouldRecommendProvider = StateProvider<bool?>((ref) => null);
final writtenReviewProvider = StateProvider<String>((ref) => '');
