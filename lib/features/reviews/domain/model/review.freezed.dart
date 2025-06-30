// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return _Review.fromJson(json);
}

/// @nodoc
mixin _$Review {
  String? get reviewId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get studioId => throw _privateConstructorUsedError;
  int get experienceRating => throw _privateConstructorUsedError;
  int get instrumentRating => throw _privateConstructorUsedError;
  bool? get wouldRecommend => throw _privateConstructorUsedError;
  String? get writtenReview => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampNullableConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewCopyWith<Review> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewCopyWith<$Res> {
  factory $ReviewCopyWith(Review value, $Res Function(Review) then) =
      _$ReviewCopyWithImpl<$Res, Review>;
  @useResult
  $Res call(
      {String? reviewId,
      String userId,
      String studioId,
      int experienceRating,
      int instrumentRating,
      bool? wouldRecommend,
      String? writtenReview,
      @TimestampConverter() DateTime createdAt,
      @TimestampNullableConverter() DateTime? updatedAt,
      List<String> images});
}

/// @nodoc
class _$ReviewCopyWithImpl<$Res, $Val extends Review>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = freezed,
    Object? userId = null,
    Object? studioId = null,
    Object? experienceRating = null,
    Object? instrumentRating = null,
    Object? wouldRecommend = freezed,
    Object? writtenReview = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      reviewId: freezed == reviewId
          ? _value.reviewId
          : reviewId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      studioId: null == studioId
          ? _value.studioId
          : studioId // ignore: cast_nullable_to_non_nullable
              as String,
      experienceRating: null == experienceRating
          ? _value.experienceRating
          : experienceRating // ignore: cast_nullable_to_non_nullable
              as int,
      instrumentRating: null == instrumentRating
          ? _value.instrumentRating
          : instrumentRating // ignore: cast_nullable_to_non_nullable
              as int,
      wouldRecommend: freezed == wouldRecommend
          ? _value.wouldRecommend
          : wouldRecommend // ignore: cast_nullable_to_non_nullable
              as bool?,
      writtenReview: freezed == writtenReview
          ? _value.writtenReview
          : writtenReview // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewImplCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$$ReviewImplCopyWith(
          _$ReviewImpl value, $Res Function(_$ReviewImpl) then) =
      __$$ReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? reviewId,
      String userId,
      String studioId,
      int experienceRating,
      int instrumentRating,
      bool? wouldRecommend,
      String? writtenReview,
      @TimestampConverter() DateTime createdAt,
      @TimestampNullableConverter() DateTime? updatedAt,
      List<String> images});
}

/// @nodoc
class __$$ReviewImplCopyWithImpl<$Res>
    extends _$ReviewCopyWithImpl<$Res, _$ReviewImpl>
    implements _$$ReviewImplCopyWith<$Res> {
  __$$ReviewImplCopyWithImpl(
      _$ReviewImpl _value, $Res Function(_$ReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviewId = freezed,
    Object? userId = null,
    Object? studioId = null,
    Object? experienceRating = null,
    Object? instrumentRating = null,
    Object? wouldRecommend = freezed,
    Object? writtenReview = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? images = null,
  }) {
    return _then(_$ReviewImpl(
      reviewId: freezed == reviewId
          ? _value.reviewId
          : reviewId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      studioId: null == studioId
          ? _value.studioId
          : studioId // ignore: cast_nullable_to_non_nullable
              as String,
      experienceRating: null == experienceRating
          ? _value.experienceRating
          : experienceRating // ignore: cast_nullable_to_non_nullable
              as int,
      instrumentRating: null == instrumentRating
          ? _value.instrumentRating
          : instrumentRating // ignore: cast_nullable_to_non_nullable
              as int,
      wouldRecommend: freezed == wouldRecommend
          ? _value.wouldRecommend
          : wouldRecommend // ignore: cast_nullable_to_non_nullable
              as bool?,
      writtenReview: freezed == writtenReview
          ? _value.writtenReview
          : writtenReview // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewImpl extends _Review {
  const _$ReviewImpl(
      {this.reviewId,
      required this.userId,
      required this.studioId,
      this.experienceRating = 0,
      this.instrumentRating = 0,
      this.wouldRecommend,
      this.writtenReview,
      @TimestampConverter() required this.createdAt,
      @TimestampNullableConverter() this.updatedAt,
      final List<String> images = const []})
      : _images = images,
        super._();

  factory _$ReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewImplFromJson(json);

  @override
  final String? reviewId;
  @override
  final String userId;
  @override
  final String studioId;
  @override
  @JsonKey()
  final int experienceRating;
  @override
  @JsonKey()
  final int instrumentRating;
  @override
  final bool? wouldRecommend;
  @override
  final String? writtenReview;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampNullableConverter()
  final DateTime? updatedAt;
  final List<String> _images;
  @override
  @JsonKey()
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'Review(reviewId: $reviewId, userId: $userId, studioId: $studioId, experienceRating: $experienceRating, instrumentRating: $instrumentRating, wouldRecommend: $wouldRecommend, writtenReview: $writtenReview, createdAt: $createdAt, updatedAt: $updatedAt, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewImpl &&
            (identical(other.reviewId, reviewId) ||
                other.reviewId == reviewId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.studioId, studioId) ||
                other.studioId == studioId) &&
            (identical(other.experienceRating, experienceRating) ||
                other.experienceRating == experienceRating) &&
            (identical(other.instrumentRating, instrumentRating) ||
                other.instrumentRating == instrumentRating) &&
            (identical(other.wouldRecommend, wouldRecommend) ||
                other.wouldRecommend == wouldRecommend) &&
            (identical(other.writtenReview, writtenReview) ||
                other.writtenReview == writtenReview) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      reviewId,
      userId,
      studioId,
      experienceRating,
      instrumentRating,
      wouldRecommend,
      writtenReview,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_images));

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      __$$ReviewImplCopyWithImpl<_$ReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewImplToJson(
      this,
    );
  }
}

abstract class _Review extends Review {
  const factory _Review(
      {final String? reviewId,
      required final String userId,
      required final String studioId,
      final int experienceRating,
      final int instrumentRating,
      final bool? wouldRecommend,
      final String? writtenReview,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampNullableConverter() final DateTime? updatedAt,
      final List<String> images}) = _$ReviewImpl;
  const _Review._() : super._();

  factory _Review.fromJson(Map<String, dynamic> json) = _$ReviewImpl.fromJson;

  @override
  String? get reviewId;
  @override
  String get userId;
  @override
  String get studioId;
  @override
  int get experienceRating;
  @override
  int get instrumentRating;
  @override
  bool? get wouldRecommend;
  @override
  String? get writtenReview;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampNullableConverter()
  DateTime? get updatedAt;
  @override
  List<String> get images;

  /// Create a copy of Review
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewImplCopyWith<_$ReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
