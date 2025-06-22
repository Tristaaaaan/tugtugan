import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/reviews/domain/review_repository.dart';
import 'package:tugtugan/features/reviews/presentation/provider/review_provider.dart';

import 'review_state.dart';

final reviewContentControllerProvider =
    StateNotifierProvider.family<ReviewContentController, ReviewState, String>(
  (ref, studioId) => ReviewContentController(
    ref.watch(reviewRepositoryProvider),
    studioId,
  ),
);

class ReviewContentController extends StateNotifier<ReviewState> {
  final ReviewRepository _reviewContentRepository;
  final String studioId;

  ReviewContentController(this._reviewContentRepository, this.studioId)
      : super(const ReviewState.initial()) {
    reviewContentData();
  }

  Future<void> reviewContentData() async {
    state = const ReviewState.loading();

    try {
      final reviewData = await _reviewContentRepository.getReviews(
        studioId, // Use the stored studioId
      );

      state = ReviewState.loaded(
        review: reviewData,
      );
    } catch (e) {
      state = ReviewState.error(e.toString());
    }
  }

  Future<void> refreshDashboard() async {
    await reviewContentData();
  }
}
