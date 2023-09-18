import 'dart:typed_data';

import '../../models/camera_description/camera_description.dart';

/// An abstract interface representing the core functionalities of a camera.
///
/// This interface is intended to be implemented by platform-specific camera classes
/// to provide a consistent API for camera operations across different platforms.
abstract class CameraInterface {
  /// Initializes the camera based on the provided [cameraDescription].
  ///
  /// Implementations should set up the camera resources and prepare the camera for streaming.
  Future<void> initializeCamera(CameraDescription cameraDescription);

  /// Starts the camera stream.
  ///
  /// Implementations should begin streaming the camera preview after this method is called.
  Future<void> startStream();

  /// Stops the camera stream.
  ///
  /// Implementations should halt the camera preview and release any resources if necessary.
  Future<void> stopStream();

  /// Captures a single image from the camera stream.
  ///
  /// Returns a [Uint8List] containing the image data.
  Future<Uint8List?> captureImage([dynamic videoElement]);
}
