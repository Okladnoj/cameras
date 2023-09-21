import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../models/cameras/android_camera.dart';
import '../../models/cameras/ios_camera.dart';
import '../interfaces/camera_controller.dart';
import '../../models/camera_description/camera_description.dart';
import '../../models/enums/supported_platforms.dart';

/// Controller for managing camera functionalities.
///
/// This controller provides methods to interact with the camera based on the platform.
class ControllerMobile extends CameraController {
  /// Constructs a [ControllerMobile] for the given platform [platform].

  ControllerMobile._({
    required super.platform,
    required super.camera,
  });

  factory ControllerMobile.init(SuppPlatform platform) {
    switch (platform) {
      case SuppPlatform.android:
        return ControllerMobile._(
          platform: platform,
          camera: AndroidCamera(),
        );
      case SuppPlatform.ios:
        return ControllerMobile._(
          platform: platform,
          camera: IOSCamera(),
        );
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Initializes the camera using the provided [cameraDescription].
  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    camera.initializeCamera(cameraDescription);
  }

  /// Starts the camera stream for the current platform.
  @override
  Future<void> startStream() async {
    return camera.startStream();
  }

  /// Stops the camera stream for the current platform.
  @override
  Future<void> stopStream() async {
    return camera.stopStream();
  }

  /// Captures an image using the camera on the current platform.
  ///
  /// Returns a [Uint8List] that contains the image data.
  @override
  Future<Uint8List?> captureImage() async {
    return camera.captureImage();
  }

  /// Builds the camera preview widget based on the current platform.
  @override
  Widget buildPreview(BuildContext context) {
    switch (platform) {
      case SuppPlatform.android:
        return _buildAndroidPreview();
      case SuppPlatform.ios:
        return _buildIosPreview();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Placeholder for building the camera preview widget for mobile platforms.
  ///
  /// This method should be implemented to return the camera preview for Android and iOS.
  Widget _buildAndroidPreview() {
    final camera = this.camera;
    if (camera is! AndroidCamera) return const SizedBox.shrink();

    final controller = camera.controller;
    if (controller == null) return const SizedBox.shrink();

    if (!controller.value.isInitialized) return const SizedBox.shrink();

    return controller.buildPreview();
  }

  /// Placeholder for building the camera preview widget for mobile platforms.
  ///
  /// This method should be implemented to return the camera preview for Android and iOS.
  Widget _buildIosPreview() {
    final camera = this.camera;
    if (camera is! IOSCamera) return const SizedBox.shrink();

    final controller = camera.controller;
    if (controller == null) return const SizedBox.shrink();

    if (!controller.value.isInitialized) return const SizedBox.shrink();

    return controller.buildPreview();
  }
}
