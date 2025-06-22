// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      reviewId: json['reviewId'] as String?,
      userId: json['userId'] as String,
      studioId: json['studioId'] as String,
      experienceRating: (json['experienceRating'] as num?)?.toInt() ?? 0,
      instrumentRating: (json['instrumentRating'] as num?)?.toInt() ?? 0,
      wouldRecommend: json['wouldRecommend'] as bool?,
      writtenReview: json['writtenReview'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt: const TimestampNullableConverter()
          .fromJson(json['updatedAt'] as Timestamp?),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'reviewId': instance.reviewId,
      'userId': instance.userId,
      'studioId': instance.studioId,
      'experienceRating': instance.experienceRating,
      'instrumentRating': instance.instrumentRating,
      'wouldRecommend': instance.wouldRecommend,
      'writtenReview': instance.writtenReview,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt':
          const TimestampNullableConverter().toJson(instance.updatedAt),
      'images': instance.images,
    };
