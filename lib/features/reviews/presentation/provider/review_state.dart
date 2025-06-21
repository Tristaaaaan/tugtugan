import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugtugan/core/appmodels/review.dart';

part 'review_state.freezed.dart';

@freezed
class ReviewState with _$ReviewState {
  const factory ReviewState.initial() = _Initial;
  const factory ReviewState.loading() = _Loading;
  const factory ReviewState.loaded({
    List<Review>? review,
  }) = _Loaded;
  const factory ReviewState.error(String message) = _Error;
  const factory ReviewState.empty() = _Empty;
}
