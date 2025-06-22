import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugtugan/core/appmodels/timestamp_conver.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const Review._();

  const factory Review({
    String? reviewId,
    required String userId,
    required String studioId,
    @Default(0) int experienceRating,
    @Default(0) int instrumentRating,
    bool? wouldRecommend,
    String? writtenReview,
    @TimestampConverter() required DateTime createdAt,
    @TimestampNullableConverter() DateTime? updatedAt,
    @Default([]) List<String> images,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  // Convert to Firestore-friendly map
  Map<String, dynamic> toMap() {
    final map = toJson();
    // Remove reviewId if it's null to avoid Firestore issues
    if (map['reviewId'] == null) {
      map.remove('reviewId');
    }
    return map;
  }

  // Optionally add a copyWith method that handles the reviewId specially
  Review copyWithNewId(String newId) {
    return copyWith(reviewId: newId);
  }
}
