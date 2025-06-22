import 'package:tugtugan/core/appmodels/review.dart';
import 'package:tugtugan/core/appmodels/review_model.dart';

abstract class ReviewRepository {
  Future<void> addReview(ReviewModel reviewData);
  Future<List<Review>> getReviews(String studioId);
}
