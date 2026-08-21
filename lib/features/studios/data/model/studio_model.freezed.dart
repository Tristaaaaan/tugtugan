// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'studio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StudioModel {
  String get id => throw _privateConstructorUsedError;
  String get studioName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  GeoPoint get location => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get followers => throw _privateConstructorUsedError;
  BusinessHoursModel? get businessHours => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StudioModelCopyWith<StudioModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudioModelCopyWith<$Res> {
  factory $StudioModelCopyWith(
          StudioModel value, $Res Function(StudioModel) then) =
      _$StudioModelCopyWithImpl<$Res, StudioModel>;
  @useResult
  $Res call(
      {String id,
      String studioName,
      String description,
      String address,
      GeoPoint location,
      String imageUrl,
      List<String> followers,
      BusinessHoursModel? businessHours});

  $BusinessHoursModelCopyWith<$Res>? get businessHours;
}

/// @nodoc
class _$StudioModelCopyWithImpl<$Res, $Val extends StudioModel>
    implements $StudioModelCopyWith<$Res> {
  _$StudioModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studioName = null,
    Object? description = null,
    Object? address = null,
    Object? location = null,
    Object? imageUrl = null,
    Object? followers = null,
    Object? businessHours = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studioName: null == studioName
          ? _value.studioName
          : studioName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      followers: null == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      businessHours: freezed == businessHours
          ? _value.businessHours
          : businessHours // ignore: cast_nullable_to_non_nullable
              as BusinessHoursModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BusinessHoursModelCopyWith<$Res>? get businessHours {
    if (_value.businessHours == null) {
      return null;
    }

    return $BusinessHoursModelCopyWith<$Res>(_value.businessHours!, (value) {
      return _then(_value.copyWith(businessHours: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StudioModelImplCopyWith<$Res>
    implements $StudioModelCopyWith<$Res> {
  factory _$$StudioModelImplCopyWith(
          _$StudioModelImpl value, $Res Function(_$StudioModelImpl) then) =
      __$$StudioModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String studioName,
      String description,
      String address,
      GeoPoint location,
      String imageUrl,
      List<String> followers,
      BusinessHoursModel? businessHours});

  @override
  $BusinessHoursModelCopyWith<$Res>? get businessHours;
}

/// @nodoc
class __$$StudioModelImplCopyWithImpl<$Res>
    extends _$StudioModelCopyWithImpl<$Res, _$StudioModelImpl>
    implements _$$StudioModelImplCopyWith<$Res> {
  __$$StudioModelImplCopyWithImpl(
      _$StudioModelImpl _value, $Res Function(_$StudioModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studioName = null,
    Object? description = null,
    Object? address = null,
    Object? location = null,
    Object? imageUrl = null,
    Object? followers = null,
    Object? businessHours = freezed,
  }) {
    return _then(_$StudioModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      studioName: null == studioName
          ? _value.studioName
          : studioName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      followers: null == followers
          ? _value._followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      businessHours: freezed == businessHours
          ? _value.businessHours
          : businessHours // ignore: cast_nullable_to_non_nullable
              as BusinessHoursModel?,
    ));
  }
}

/// @nodoc

class _$StudioModelImpl extends _StudioModel {
  const _$StudioModelImpl(
      {required this.id,
      required this.studioName,
      required this.description,
      required this.address,
      required this.location,
      required this.imageUrl,
      required final List<String> followers,
      this.businessHours})
      : _followers = followers,
        super._();

  @override
  final String id;
  @override
  final String studioName;
  @override
  final String description;
  @override
  final String address;
  @override
  final GeoPoint location;
  @override
  final String imageUrl;
  final List<String> _followers;
  @override
  List<String> get followers {
    if (_followers is EqualUnmodifiableListView) return _followers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followers);
  }

  @override
  final BusinessHoursModel? businessHours;

  @override
  String toString() {
    return 'StudioModel(id: $id, studioName: $studioName, description: $description, address: $address, location: $location, imageUrl: $imageUrl, followers: $followers, businessHours: $businessHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudioModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studioName, studioName) ||
                other.studioName == studioName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality()
                .equals(other._followers, _followers) &&
            (identical(other.businessHours, businessHours) ||
                other.businessHours == businessHours));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studioName,
      description,
      address,
      location,
      imageUrl,
      const DeepCollectionEquality().hash(_followers),
      businessHours);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudioModelImplCopyWith<_$StudioModelImpl> get copyWith =>
      __$$StudioModelImplCopyWithImpl<_$StudioModelImpl>(this, _$identity);
}

abstract class _StudioModel extends StudioModel {
  const factory _StudioModel(
      {required final String id,
      required final String studioName,
      required final String description,
      required final String address,
      required final GeoPoint location,
      required final String imageUrl,
      required final List<String> followers,
      final BusinessHoursModel? businessHours}) = _$StudioModelImpl;
  const _StudioModel._() : super._();

  @override
  String get id;
  @override
  String get studioName;
  @override
  String get description;
  @override
  String get address;
  @override
  GeoPoint get location;
  @override
  String get imageUrl;
  @override
  List<String> get followers;
  @override
  BusinessHoursModel? get businessHours;
  @override
  @JsonKey(ignore: true)
  _$$StudioModelImplCopyWith<_$StudioModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
