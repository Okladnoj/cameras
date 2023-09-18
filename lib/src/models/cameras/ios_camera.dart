import 'package:camera/camera.dart' as camera;
import 'package:flutter/services.dart';

import '../../../../a_cameras.dart';
import '../../platforms/interfaces/camera_interface.dart';
import '../../utils/logger/logger_mobile.dart';

/// Represents the iOS implementation of the [CameraInterface].
/// Provides methods to interact with the camera on an iOS platform.
class IOSCamera implements CameraInterface {
  camera.CameraController? _controller;

  /// Initializes the camera based on the provided [cameraDescription].
  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    try {
      _controller = camera.CameraController(
        cameraDescription.toHelpLib,
        camera.ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: camera.ImageFormatGroup.yuv420,
      );
      await _controller?.initialize();
    } on PlatformException catch (e) {
      loggerMobile.e('Error initializing camera: ${e.message}');
    }
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
  Future<Uint8List?> captureImage([dynamic element]) async {
    try {
      final file = await _controller?.takePicture();
      final bites = file?.readAsBytes();
      return bites;
    } on PlatformException catch (e) {
      loggerMobile.e('Error capturing image: ${e.message}');
      return null;
    }
  }

  camera.CameraController? get controller => _controller;
}
