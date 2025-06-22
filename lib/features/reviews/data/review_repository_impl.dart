import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugtugan/core/appmodels/review.dart';

import '../../../core/appmodels/review_model.dart';
import '../domain/review_repository.dart';

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
  Future<List<Review>> getReviews(String studioId) async {
    try {
      // Validate studioId first
      if (studioId.isEmpty) {
        throw ArgumentError('studioId cannot be empty');
      }
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

      return snapshot.docs.map((doc) {
        // Include document ID in the data
        final data = doc.data()..['reviewId'] = doc.id;
        return Review.fromJson(data);
      }).toList();
    } on FirebaseException catch (e) {
      // Firebase-specific errors
      print('Firestore error fetching reviews: ${e.code} - ${e.message}');
      return [];
    } catch (e) {
      // Other errors
      print('Unexpected error fetching reviews: $e');
      return [];
    }
  }
}
