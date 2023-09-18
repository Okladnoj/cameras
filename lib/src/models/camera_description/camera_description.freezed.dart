// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CameraDescription _$CameraDescriptionFromJson(Map<String, dynamic> json) {
  return _CameraDescription.fromJson(json);
}

/// @nodoc
mixin _$CameraDescription {
  /// Unique identifier for the camera.
  String get id => throw _privateConstructorUsedError;

  /// A user-friendly name or description of the camera.
  String get label => throw _privateConstructorUsedError;

  /// The direction that the camera's lens is facing.
  /// This can be 'front', 'back', etc.
  /// Might be `null` if the lens direction is unknown or not specified.
  @LensDirectionConverter()
  LensDirection get lensDirection => throw _privateConstructorUsedError;

  /// Clockwise angle through which the output image needs to be rotated to be upright on the device screen in its native orientation.
  ///
  /// **Range of valid values:**
  /// 0, 90, 180, 270
  ///
  /// On Android, also defines the direction of rolling shutter readout, which
  /// is from top to bottom in the sensor's coordinate system.
  int get sensorOrientation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CameraDescriptionCopyWith<CameraDescription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraDescriptionCopyWith<$Res> {
  factory $CameraDescriptionCopyWith(
          CameraDescription value, $Res Function(CameraDescription) then) =
      _$CameraDescriptionCopyWithImpl<$Res, CameraDescription>;
  @useResult
  $Res call(
      {String id,
      String label,
      @LensDirectionConverter() LensDirection lensDirection,
      int sensorOrientation});
}

/// @nodoc
class _$CameraDescriptionCopyWithImpl<$Res, $Val extends CameraDescription>
    implements $CameraDescriptionCopyWith<$Res> {
  _$CameraDescriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? lensDirection = null,
    Object? sensorOrientation = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      lensDirection: null == lensDirection
          ? _value.lensDirection
          : lensDirection // ignore: cast_nullable_to_non_nullable
              as LensDirection,
      sensorOrientation: null == sensorOrientation
          ? _value.sensorOrientation
          : sensorOrientation // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CameraDescriptionCopyWith<$Res>
    implements $CameraDescriptionCopyWith<$Res> {
  factory _$$_CameraDescriptionCopyWith(_$_CameraDescription value,
          $Res Function(_$_CameraDescription) then) =
      __$$_CameraDescriptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      @LensDirectionConverter() LensDirection lensDirection,
      int sensorOrientation});
}

/// @nodoc
class __$$_CameraDescriptionCopyWithImpl<$Res>
    extends _$CameraDescriptionCopyWithImpl<$Res, _$_CameraDescription>
    implements _$$_CameraDescriptionCopyWith<$Res> {
  __$$_CameraDescriptionCopyWithImpl(
      _$_CameraDescription _value, $Res Function(_$_CameraDescription) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? lensDirection = null,
    Object? sensorOrientation = null,
  }) {
    return _then(_$_CameraDescription(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      lensDirection: null == lensDirection
          ? _value.lensDirection
          : lensDirection // ignore: cast_nullable_to_non_nullable
              as LensDirection,
      sensorOrientation: null == sensorOrientation
          ? _value.sensorOrientation
          : sensorOrientation // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CameraDescription extends _CameraDescription {
  const _$_CameraDescription(
      {required this.id,
      required this.label,
      @LensDirectionConverter() this.lensDirection = LensDirection.unknown,
      this.sensorOrientation = 90})
      : super._();

  factory _$_CameraDescription.fromJson(Map<String, dynamic> json) =>
      _$$_CameraDescriptionFromJson(json);

  /// Unique identifier for the camera.
  @override
  final String id;

  /// A user-friendly name or description of the camera.
  @override
  final String label;

  /// The direction that the camera's lens is facing.
  /// This can be 'front', 'back', etc.
  /// Might be `null` if the lens direction is unknown or not specified.
  @override
  @JsonKey()
  @LensDirectionConverter()
  final LensDirection lensDirection;

  /// Clockwise angle through which the output image needs to be rotated to be upright on the device screen in its native orientation.
  ///
  /// **Range of valid values:**
  /// 0, 90, 180, 270
  ///
  /// On Android, also defines the direction of rolling shutter readout, which
  /// is from top to bottom in the sensor's coordinate system.
  @override
  @JsonKey()
  final int sensorOrientation;

  @override
  String toString() {
    return 'CameraDescription(id: $id, label: $label, lensDirection: $lensDirection, sensorOrientation: $sensorOrientation)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CameraDescriptionCopyWith<_$_CameraDescription> get copyWith =>
      __$$_CameraDescriptionCopyWithImpl<_$_CameraDescription>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CameraDescriptionToJson(
      this,
    );
  }
}

abstract class _CameraDescription extends CameraDescription {
  const factory _CameraDescription(
      {required final String id,
      required final String label,
      @LensDirectionConverter() final LensDirection lensDirection,
      final int sensorOrientation}) = _$_CameraDescription;
  const _CameraDescription._() : super._();

  factory _CameraDescription.fromJson(Map<String, dynamic> json) =
      _$_CameraDescription.fromJson;

  @override

  /// Unique identifier for the camera.
  String get id;
  @override

  /// A user-friendly name or description of the camera.
  String get label;
  @override

  /// The direction that the camera's lens is facing.
  /// This can be 'front', 'back', etc.
  /// Might be `null` if the lens direction is unknown or not specified.
  @LensDirectionConverter()
  LensDirection get lensDirection;
  @override

  /// Clockwise angle through which the output image needs to be rotated to be upright on the device screen in its native orientation.
  ///
  /// **Range of valid values:**
  /// 0, 90, 180, 270
  ///
  /// On Android, also defines the direction of rolling shutter readout, which
  /// is from top to bottom in the sensor's coordinate system.
  int get sensorOrientation;
  @override
  @JsonKey(ignore: true)
  _$$_CameraDescriptionCopyWith<_$_CameraDescription> get copyWith =>
      throw _privateConstructorUsedError;
}
