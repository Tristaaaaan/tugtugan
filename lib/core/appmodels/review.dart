import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugtugan/core/appmodels/timestamp_conver.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const Review._(); // Added private constructor for methods

  const factory Review({
    String? reviewId, // Make this nullable for new reviews
    required String userId,
    required String studioId,
    required int experienceRating,
    required int instrumentRating,
    bool? wouldRecommend,
    String? writtenReview,
    @TimestampConverter() required DateTime createdAt,
    @TimestampNullableConverter() DateTime? updatedAt,
    List<String>? images,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  // Add a method to convert to Firestore-friendly map
  Map<String, dynamic> toMap() {
    return toJson()..remove('reviewId');
  }
}
