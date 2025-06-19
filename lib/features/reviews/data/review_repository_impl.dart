import '../../../core/appmodels/review_model.dart';
import '../domain/review_repository.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  @override
  Future<void> addReview(ReviewModel reviewData) {
    // TODO: implement addReview
    throw UnimplementedError();
  }

  Stream<List<ReviewModel>> streamReviews(String studioId) {
    // TODO: implement streamReviews
    throw UnimplementedError();
  }
}
