// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CameraDescription _$$_CameraDescriptionFromJson(Map<String, dynamic> json) =>
    _$_CameraDescription(
      id: json['id'] as String,
      label: json['label'] as String,
      lensDirection: json['lensDirection'] == null
          ? LensDirection.unknown
          : const LensDirectionConverter()
              .fromJson(json['lensDirection'] as String?),
      sensorOrientation: json['sensorOrientation'] as int? ?? 90,
    );

Map<String, dynamic> _$$_CameraDescriptionToJson(
        _$_CameraDescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'lensDirection':
          const LensDirectionConverter().toJson(instance.lensDirection),
      'sensorOrientation': instance.sensorOrientation,
    };
