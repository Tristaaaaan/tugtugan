import 'package:tugtugan/core/appmodels/review_model.dart';

abstract class ReviewRepository {
  Future<void> addReview(ReviewModel reviewData);

  Stream<List<ReviewModel>> streamReviews(String studioId);
}
