// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_hours_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BusinessHoursModel {
  List<Weekday> get days => throw _privateConstructorUsedError;
  int get openAt => throw _privateConstructorUsedError;
  int get closeAt => throw _privateConstructorUsedError;
  int get slotDuration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BusinessHoursModelCopyWith<BusinessHoursModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessHoursModelCopyWith<$Res> {
  factory $BusinessHoursModelCopyWith(
          BusinessHoursModel value, $Res Function(BusinessHoursModel) then) =
      _$BusinessHoursModelCopyWithImpl<$Res, BusinessHoursModel>;
  @useResult
  $Res call({List<Weekday> days, int openAt, int closeAt, int slotDuration});
}

/// @nodoc
class _$BusinessHoursModelCopyWithImpl<$Res, $Val extends BusinessHoursModel>
    implements $BusinessHoursModelCopyWith<$Res> {
  _$BusinessHoursModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? openAt = null,
    Object? closeAt = null,
    Object? slotDuration = null,
  }) {
    return _then(_value.copyWith(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Weekday>,
      openAt: null == openAt
          ? _value.openAt
          : openAt // ignore: cast_nullable_to_non_nullable
              as int,
      closeAt: null == closeAt
          ? _value.closeAt
          : closeAt // ignore: cast_nullable_to_non_nullable
              as int,
      slotDuration: null == slotDuration
          ? _value.slotDuration
          : slotDuration // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusinessHoursModelImplCopyWith<$Res>
    implements $BusinessHoursModelCopyWith<$Res> {
  factory _$$BusinessHoursModelImplCopyWith(_$BusinessHoursModelImpl value,
          $Res Function(_$BusinessHoursModelImpl) then) =
      __$$BusinessHoursModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Weekday> days, int openAt, int closeAt, int slotDuration});
}

/// @nodoc
class __$$BusinessHoursModelImplCopyWithImpl<$Res>
    extends _$BusinessHoursModelCopyWithImpl<$Res, _$BusinessHoursModelImpl>
    implements _$$BusinessHoursModelImplCopyWith<$Res> {
  __$$BusinessHoursModelImplCopyWithImpl(_$BusinessHoursModelImpl _value,
      $Res Function(_$BusinessHoursModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? openAt = null,
    Object? closeAt = null,
    Object? slotDuration = null,
  }) {
    return _then(_$BusinessHoursModelImpl(
      days: null == days
          ? _value._days
          : days // ignore: cast_nullable_to_non_nullable
              as List<Weekday>,
      openAt: null == openAt
          ? _value.openAt
          : openAt // ignore: cast_nullable_to_non_nullable
              as int,
      closeAt: null == closeAt
          ? _value.closeAt
          : closeAt // ignore: cast_nullable_to_non_nullable
              as int,
      slotDuration: null == slotDuration
          ? _value.slotDuration
          : slotDuration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$BusinessHoursModelImpl extends _BusinessHoursModel {
  const _$BusinessHoursModelImpl(
      {required final List<Weekday> days,
      required this.openAt,
      required this.closeAt,
      required this.slotDuration})
      : _days = days,
        super._();

  final List<Weekday> _days;
  @override
  List<Weekday> get days {
    if (_days is EqualUnmodifiableListView) return _days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_days);
  }

  @override
  final int openAt;
  @override
  final int closeAt;
  @override
  final int slotDuration;

  @override
  String toString() {
    return 'BusinessHoursModel(days: $days, openAt: $openAt, closeAt: $closeAt, slotDuration: $slotDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessHoursModelImpl &&
            const DeepCollectionEquality().equals(other._days, _days) &&
            (identical(other.openAt, openAt) || other.openAt == openAt) &&
            (identical(other.closeAt, closeAt) || other.closeAt == closeAt) &&
            (identical(other.slotDuration, slotDuration) ||
                other.slotDuration == slotDuration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_days),
      openAt,
      closeAt,
      slotDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessHoursModelImplCopyWith<_$BusinessHoursModelImpl> get copyWith =>
      __$$BusinessHoursModelImplCopyWithImpl<_$BusinessHoursModelImpl>(
          this, _$identity);
}

abstract class _BusinessHoursModel extends BusinessHoursModel {
  const factory _BusinessHoursModel(
      {required final List<Weekday> days,
      required final int openAt,
      required final int closeAt,
      required final int slotDuration}) = _$BusinessHoursModelImpl;
  const _BusinessHoursModel._() : super._();

  @override
  List<Weekday> get days;
  @override
  int get openAt;
  @override
  int get closeAt;
  @override
  int get slotDuration;
  @override
  @JsonKey(ignore: true)
  _$$BusinessHoursModelImplCopyWith<_$BusinessHoursModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
