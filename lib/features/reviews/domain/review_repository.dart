import 'package:tugtugan/core/appmodels/review_model.dart';

abstract class ReviewRepository {
  Future<void> addReview(ReviewModel reviewData);
  Future<List<ReviewModel>> getReviews(String studioId);
}
