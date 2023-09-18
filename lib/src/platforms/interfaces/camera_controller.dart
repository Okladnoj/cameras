import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import '../../models/camera_description/camera_description.dart';
import '../../models/enums/supported_platforms.dart';
import 'camera_interface.dart';

abstract class CameraController {
  /// The platform on which the app is currently running.
  final SuppPlatform platform;

  /// Instance of the web camera (if available).
  final CameraInterface? webCamera;

  /// Instance of the Android camera (if available).
  final CameraInterface? androidCamera;

  /// Instance of the iOS camera (if available).
  final CameraInterface? iOSCamera;

  CameraController({
    required this.platform,
    this.webCamera,
    this.androidCamera,
    this.iOSCamera,
  });

  /// Constructs a [CameraController] for the given platform [p].

  /// Initializes the camera using the provided [cameraDescription].
  Future<void> initializeCamera(CameraDescription cameraDescription);

  /// Starts the camera stream for the current platform.
  Future<void> startStream();

  /// Stops the camera stream for the current platform.
  Future<void> stopStream();

  /// Captures an image using the camera on the current platform.
  ///
  /// Returns a [Uint8List] that contains the image data.
  Future<Uint8List?> captureImage();

  /// Builds the camera preview widget based on the current platform.
  Widget buildPreview(BuildContext context);
}
