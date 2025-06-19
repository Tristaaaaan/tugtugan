import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String userId;
  final String studioId;
  final int experienceRating;
  final int instrumentRating;
  final bool wouldRecommend;
  final String writtenReview;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String>? images;
  ReviewModel({
    required this.userId,
    required this.studioId,
    required this.experienceRating,
    required this.instrumentRating,
    required this.wouldRecommend,
    required this.writtenReview,
    required this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map['userId'],
      studioId: map['studioId'],
      experienceRating: map['experienceRating'],
      instrumentRating: map['instrumentRating'],
      wouldRecommend: map['wouldRecommend'],
      writtenReview: map['writtenReview'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      images: List<String>.from(map['images']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'studioId': studioId,
      'experienceRating': experienceRating,
      'instrumentRating': instrumentRating,
      'wouldRecommend': wouldRecommend,
      'writtenReview': writtenReview,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'images': images
    };
  }

  factory ReviewModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ReviewModel(
      userId: data['userId'],
      studioId: data['studioId'],
      experienceRating: data['experienceRating'],
      instrumentRating: data['instrumentRating'],
      wouldRecommend: data['wouldRecommend'],
      writtenReview: data['writtenReview'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      images: List<String>.from(data['images']),
    );
  }
}
