import 'dart:typed_data';

import '../../../cameras.dart';
import '../camera_interface.dart';

/// Represents the iOS implementation of the [CameraInterface].
/// Provides methods to interact with the camera on an iOS platform.
class IOSCamera implements CameraInterface {
  /// Initializes the camera based on the provided [cameraDescription].
  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    // TODO: Implement the iOS-specific initialization
  }

  /// Starts the camera stream.
  @override
  Future<void> startStream() async {
    // TODO: Implement the iOS-specific stream start
  }

  /// Stops the camera stream.
  @override
  Future<void> stopStream() async {
    // TODO: Implement the iOS-specific stream stop
  }

  /// Temporary implementation for capturing an image on iOS.
  /// This method needs to be implemented specifically for iOS platform.
  @override
  Future<Uint8List?> captureImage() {
    // TODO: Implement image capturing for iOS
    throw UnimplementedError('captureImage is not yet implemented for iOS');
  }
}
