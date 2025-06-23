import 'package:riverpod/riverpod.dart';
import 'package:tugtugan/core/appmodels/review.dart';
import 'package:tugtugan/core/appmodels/review_model.dart';
import 'package:tugtugan/features/reviews/data/review_repository_impl.dart';

import '../../../core/appmodels/users.dart';

abstract class ReviewRepository {
  Future<void> addReview(ReviewModel reviewData);
  Future<ReviewsData> getReviews(String studioId);
}

class ReviewsData {
  final List<Review> reviews;
  final Map<String, UserData> users; // ✅ Correct type

  ReviewsData({
    required this.reviews,
    required this.users,
  });
}

final reviewsRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepositoryImpl();
});
