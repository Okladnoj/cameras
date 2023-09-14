import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_converter/api_errors_converter.dart';
import '../enums/lens_direction.dart';

part 'camera_description.freezed.dart';
part 'camera_description.g.dart';

/// Represents a camera device available on the platform.
@freezed
class CameraDescription with _$CameraDescription {
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
    @LensDirectionConverter() LensDirection? lensDirection,
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

  static LensDirection? _lensDirection(List<dynamic> devices, dynamic device) {
    if (devices.indexOf(device) == 0) {
      return LensDirection.back;
    }
    return LensDirection.front;
  }
}
