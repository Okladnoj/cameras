import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart'
    as cpi;

import '../../utils/json_converter/api_errors_converter.dart';
import '../enums/lens_direction.dart';

part 'camera_description.freezed.dart';
part 'camera_description.g.dart';

/// Represents a camera device available on the platform.
@freezed
class CameraDescription with _$CameraDescription {
  const CameraDescription._();

  /// Constructs a new instance of [CameraDescription].
  ///
  /// - [id]: A unique identifier for the camera.
  /// - [label]: A descriptive name for the camera, which can be shown to the user.
  /// - [lensDirection]: The direction the camera lens is facing. Can be `null`.
  const factory CameraDescription({
    /// Unique identifier for the camera.
    required String id,

    /// A user-friendly name or description of the camera.
    required String label,

    /// The direction that the camera's lens is facing.
    /// This can be 'front', 'back', etc.
    /// Might be `null` if the lens direction is unknown or not specified.
    @Default(LensDirection.unknown)
    @LensDirectionConverter()
    LensDirection lensDirection,

    /// Clockwise angle through which the output image needs to be rotated to be upright on the device screen in its native orientation.
    ///
    /// **Range of valid values:**
    /// 0, 90, 180, 270
    ///
    /// On Android, also defines the direction of rolling shutter readout, which
    /// is from top to bottom in the sensor's coordinate system.
    @Default(90) int sensorOrientation,
  }) = _CameraDescription;

  factory CameraDescription.fromJson(Map<String, dynamic> json) =>
      _$CameraDescriptionFromJson(json);

  factory CameraDescription.fromJs(List<dynamic> devices, dynamic device) {
    return CameraDescription(
      id: device.deviceId,
      label: device.label,
      lensDirection: _lensDirection(devices, device),
    );
  }

  factory CameraDescription.fromHelpLib(cpi.CameraDescription camera) {
    final lens = camera.lensDirection;
    return CameraDescription(
      id: camera.name,
      label: camera.name,
      lensDirection: lens.toLens,
    );
  }

  static LensDirection _lensDirection(List<dynamic> devices, dynamic device) {
    if (devices.indexOf(device) == 0) {
      return LensDirection.back;
    }
    return LensDirection.front;
  }

  cpi.CameraDescription get toHelpLib {
    return cpi.CameraDescription(
      name: id,
      lensDirection: lensDirection.toLens,
      sensorOrientation: sensorOrientation,
    );
  }

  @override
  operator ==(dynamic other) => other is CameraDescription && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

extension CameraLensDirectionExt on cpi.CameraLensDirection {
  LensDirection get toLens {
    switch (this) {
      case cpi.CameraLensDirection.front:
        return LensDirection.front;
      case cpi.CameraLensDirection.back:
        return LensDirection.back;
      default:
        return LensDirection.unknown;
    }
  }
}

extension LensDirectionExt on LensDirection {
  cpi.CameraLensDirection get toLens {
    switch (this) {
      case LensDirection.front:
        return cpi.CameraLensDirection.front;
      case LensDirection.back:
        return cpi.CameraLensDirection.back;
      default:
        return cpi.CameraLensDirection.external;
    }
  }
}
