import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/appmodels/review_model.dart';
import '../domain/review_repository.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final FirebaseFirestore _firestore;
  ReviewRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addReview(ReviewModel reviewData) async {
    try {
      await _firestore
          .collection("studios")
          .doc(reviewData.studioId)
          .collection("reviews")
          .add(reviewData.toMap());
    } catch (e, st) {
      developer.log('Error adding review', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Stream<List<ReviewModel>> streamReviews(String studioId) {
    return _firestore
        .collection("studios")
        .doc(studioId)
        .collection("reviews")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ReviewModel.fromMap(doc.data()))
            .toList());
  }
}
