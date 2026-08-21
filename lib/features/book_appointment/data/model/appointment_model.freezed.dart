// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppointmentModel {
  String? get id => throw _privateConstructorUsedError;
  String get studioId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError;
  List<AppointmentSlotModel> get slots => throw _privateConstructorUsedError;
  String? get bookingNumber => throw _privateConstructorUsedError;
  BookingStatus? get status => throw _privateConstructorUsedError;
  int? get approvedAt => throw _privateConstructorUsedError;
  int? get createdAt => throw _privateConstructorUsedError;
  int? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppointmentModelCopyWith<AppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentModelCopyWith<$Res> {
  factory $AppointmentModelCopyWith(
          AppointmentModel value, $Res Function(AppointmentModel) then) =
      _$AppointmentModelCopyWithImpl<$Res, AppointmentModel>;
  @useResult
  $Res call(
      {String? id,
      String studioId,
      String customerId,
      List<AppointmentSlotModel> slots,
      String? bookingNumber,
      BookingStatus? status,
      int? approvedAt,
      int? createdAt,
      int? updatedAt});
}

/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res, $Val extends AppointmentModel>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? studioId = null,
    Object? customerId = null,
    Object? slots = null,
    Object? bookingNumber = freezed,
    Object? status = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      studioId: null == studioId
          ? _value.studioId
          : studioId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      slots: null == slots
          ? _value.slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<AppointmentSlotModel>,
      bookingNumber: freezed == bookingNumber
          ? _value.bookingNumber
          : bookingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookingStatus?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppointmentModelImplCopyWith<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  factory _$$AppointmentModelImplCopyWith(_$AppointmentModelImpl value,
          $Res Function(_$AppointmentModelImpl) then) =
      __$$AppointmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String studioId,
      String customerId,
      List<AppointmentSlotModel> slots,
      String? bookingNumber,
      BookingStatus? status,
      int? approvedAt,
      int? createdAt,
      int? updatedAt});
}

/// @nodoc
class __$$AppointmentModelImplCopyWithImpl<$Res>
    extends _$AppointmentModelCopyWithImpl<$Res, _$AppointmentModelImpl>
    implements _$$AppointmentModelImplCopyWith<$Res> {
  __$$AppointmentModelImplCopyWithImpl(_$AppointmentModelImpl _value,
      $Res Function(_$AppointmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? studioId = null,
    Object? customerId = null,
    Object? slots = null,
    Object? bookingNumber = freezed,
    Object? status = freezed,
    Object? approvedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$AppointmentModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      studioId: null == studioId
          ? _value.studioId
          : studioId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      slots: null == slots
          ? _value._slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<AppointmentSlotModel>,
      bookingNumber: freezed == bookingNumber
          ? _value.bookingNumber
          : bookingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BookingStatus?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AppointmentModelImpl extends _AppointmentModel {
  const _$AppointmentModelImpl(
      {this.id,
      required this.studioId,
      required this.customerId,
      required final List<AppointmentSlotModel> slots,
      this.bookingNumber,
      this.status,
      this.approvedAt,
      this.createdAt,
      this.updatedAt})
      : _slots = slots,
        super._();

  @override
  final String? id;
  @override
  final String studioId;
  @override
  final String customerId;
  final List<AppointmentSlotModel> _slots;
  @override
  List<AppointmentSlotModel> get slots {
    if (_slots is EqualUnmodifiableListView) return _slots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slots);
  }

  @override
  final String? bookingNumber;
  @override
  final BookingStatus? status;
  @override
  final int? approvedAt;
  @override
  final int? createdAt;
  @override
  final int? updatedAt;

  @override
  String toString() {
    return 'AppointmentModel(id: $id, studioId: $studioId, customerId: $customerId, slots: $slots, bookingNumber: $bookingNumber, status: $status, approvedAt: $approvedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppointmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studioId, studioId) ||
                other.studioId == studioId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            const DeepCollectionEquality().equals(other._slots, _slots) &&
            (identical(other.bookingNumber, bookingNumber) ||
                other.bookingNumber == bookingNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studioId,
      customerId,
      const DeepCollectionEquality().hash(_slots),
      bookingNumber,
      status,
      approvedAt,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      __$$AppointmentModelImplCopyWithImpl<_$AppointmentModelImpl>(
          this, _$identity);
}

abstract class _AppointmentModel extends AppointmentModel {
  const factory _AppointmentModel(
      {final String? id,
      required final String studioId,
      required final String customerId,
      required final List<AppointmentSlotModel> slots,
      final String? bookingNumber,
      final BookingStatus? status,
      final int? approvedAt,
      final int? createdAt,
      final int? updatedAt}) = _$AppointmentModelImpl;
  const _AppointmentModel._() : super._();

  @override
  String? get id;
  @override
  String get studioId;
  @override
  String get customerId;
  @override
  List<AppointmentSlotModel> get slots;
  @override
  String? get bookingNumber;
  @override
  BookingStatus? get status;
  @override
  int? get approvedAt;
  @override
  int? get createdAt;
  @override
  int? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$AppointmentModelImplCopyWith<_$AppointmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
