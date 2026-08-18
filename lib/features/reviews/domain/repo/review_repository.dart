import 'package:riverpod/riverpod.dart';

import '../../../../core/appmodels/review_model.dart';
import '../../../../core/appmodels/users.dart';
import '../../data/review_repository_impl.dart';
import '../model/review.dart';

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
