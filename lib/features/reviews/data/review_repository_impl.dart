import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/appmodels/review_model.dart';
import '../../../core/appmodels/users.dart';
import '../domain/model/review.dart';
import '../domain/repo/review_repository.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final FirebaseFirestore _firestore;

  ReviewRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> addReview(ReviewModel reviewData) async {
    try {
      final docRef = _firestore
          .collection("studios")
          .doc(reviewData.studioId)
          .collection("reviews")
          .doc();

      final reviewWithId = reviewData.toMap()..['reviewId'] = docRef.id;

      await docRef.set(reviewWithId);
    } catch (e, st) {
      developer.log('Error adding review', error: e, stackTrace: st);
      rethrow;
    }
  }

  @override
  Future<ReviewsData> getReviews(String studioId) async {
    try {
      if (studioId.isEmpty) {
        throw ArgumentError('studioId cannot be empty');
      }

      // Fetch reviews
      final snapshot = await _firestore
          .collection("studios")
          .doc(studioId)
          .collection("reviews")
          .where("writtenReview", isNotEqualTo: "")
          .orderBy("writtenReview")
          .orderBy("experienceRating", descending: true)
          .orderBy("__name__", descending: true)
          .limit(10)
          .get();

      final reviews = snapshot.docs.map((doc) {
        final data = doc.data()..['reviewId'] = doc.id;

        if (data['userId'] == null) {
          throw StateError('Missing userId in review document: ${doc.id}');
        }

        return Review.fromJson(data);
      }).toList();

      // Get unique userIds from the reviews
      final userIds = reviews.map((r) => r.userId).toSet().toList();

      final userMap = <String, UserData>{};

      if (userIds.isNotEmpty) {
        final userQuery = await _firestore
            .collection("users")
            .where(FieldPath.documentId, whereIn: userIds)
            .get();

        userMap.addEntries(
          userQuery.docs.map(
            (doc) => MapEntry(doc.id, UserData.fromJson(doc.data())),
          ),
        );
      }

      return ReviewsData(
        reviews: reviews,
        users: userMap,
      );
    } catch (e, st) {
      developer.log('Error fetching reviews with users',
          error: e, stackTrace: st);
      return ReviewsData(reviews: [], users: {});
    }
  }
}
