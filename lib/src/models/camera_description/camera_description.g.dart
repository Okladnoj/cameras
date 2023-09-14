// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CameraDescription _$$_CameraDescriptionFromJson(Map<String, dynamic> json) =>
    _$_CameraDescription(
      id: json['id'] as String,
      label: json['label'] as String,
      lensDirection:
          $enumDecodeNullable(_$LensDirectionEnumMap, json['lensDirection']),
    );

Map<String, dynamic> _$$_CameraDescriptionToJson(
        _$_CameraDescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'lensDirection': _$LensDirectionEnumMap[instance.lensDirection],
    };

const _$LensDirectionEnumMap = {
  LensDirection.front: 'front',
  LensDirection.back: 'back',
  LensDirection.unknown: 'unknown',
};
