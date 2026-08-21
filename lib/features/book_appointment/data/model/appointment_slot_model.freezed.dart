// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_slot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppointmentSlotModel {
  int get startAt => throw _privateConstructorUsedError;
  int get endAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppointmentSlotModelCopyWith<AppointmentSlotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentSlotModelCopyWith<$Res> {
  factory $AppointmentSlotModelCopyWith(AppointmentSlotModel value,
          $Res Function(AppointmentSlotModel) then) =
      _$AppointmentSlotModelCopyWithImpl<$Res, AppointmentSlotModel>;
  @useResult
  $Res call({int startAt, int endAt});
}

/// @nodoc
class _$AppointmentSlotModelCopyWithImpl<$Res,
        $Val extends AppointmentSlotModel>
    implements $AppointmentSlotModelCopyWith<$Res> {
  _$AppointmentSlotModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startAt = null,
    Object? endAt = null,
  }) {
    return _then(_value.copyWith(
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as int,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentSlotModelImplCopyWith<$Res>
    implements $AppointmentSlotModelCopyWith<$Res> {
  factory _$$AppointmentSlotModelImplCopyWith(_$AppointmentSlotModelImpl value,
          $Res Function(_$AppointmentSlotModelImpl) then) =
      __$$AppointmentSlotModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int startAt, int endAt});
}

/// @nodoc
class __$$AppointmentSlotModelImplCopyWithImpl<$Res>
    extends _$AppointmentSlotModelCopyWithImpl<$Res, _$AppointmentSlotModelImpl>
    implements _$$AppointmentSlotModelImplCopyWith<$Res> {
  __$$AppointmentSlotModelImplCopyWithImpl(_$AppointmentSlotModelImpl _value,
      $Res Function(_$AppointmentSlotModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startAt = null,
    Object? endAt = null,
  }) {
    return _then(_$AppointmentSlotModelImpl(
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as int,
      endAt: null == endAt
          ? _value.endAt
          : endAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AppointmentSlotModelImpl extends _AppointmentSlotModel {
  const _$AppointmentSlotModelImpl({required this.startAt, required this.endAt})
      : super._();

  @override
  final int startAt;
  @override
  final int endAt;

  @override
  String toString() {
    return 'AppointmentSlotModel(startAt: $startAt, endAt: $endAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentSlotModelImpl &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.endAt, endAt) || other.endAt == endAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startAt, endAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentSlotModelImplCopyWith<_$AppointmentSlotModelImpl>
      get copyWith =>
          __$$AppointmentSlotModelImplCopyWithImpl<_$AppointmentSlotModelImpl>(
              this, _$identity);
}

abstract class _AppointmentSlotModel extends AppointmentSlotModel {
  const factory _AppointmentSlotModel(
      {required final int startAt,
      required final int endAt}) = _$AppointmentSlotModelImpl;
  const _AppointmentSlotModel._() : super._();

  @override
  int get startAt;
  @override
  int get endAt;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentSlotModelImplCopyWith<_$AppointmentSlotModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
