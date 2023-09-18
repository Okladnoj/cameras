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
    super.androidCamera,
    super.iOSCamera,
  });

  factory ControllerMobile.init(SuppPlatform platform) {
    switch (platform) {
      case SuppPlatform.android:
        return ControllerMobile._(
          platform: platform,
          androidCamera: AndroidCamera(),
        );
      case SuppPlatform.ios:
        return ControllerMobile._(
          platform: platform,
          iOSCamera: IOSCamera(),
        );
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Initializes the camera using the provided [cameraDescription].
  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    switch (platform) {
      case SuppPlatform.android:
        return androidCamera?.initializeCamera(cameraDescription);
      case SuppPlatform.ios:
        return iOSCamera?.initializeCamera(cameraDescription);
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Starts the camera stream for the current platform.
  @override
  Future<void> startStream() async {
    switch (platform) {
      case SuppPlatform.android:
        return androidCamera?.startStream();
      case SuppPlatform.ios:
        return iOSCamera?.startStream();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Stops the camera stream for the current platform.
  @override
  Future<void> stopStream() async {
    switch (platform) {
      case SuppPlatform.android:
        return androidCamera?.stopStream();
      case SuppPlatform.ios:
        return iOSCamera?.stopStream();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Captures an image using the camera on the current platform.
  ///
  /// Returns a [Uint8List] that contains the image data.
  @override
  Future<Uint8List?> captureImage() async {
    switch (platform) {
      case SuppPlatform.android:
        return androidCamera?.captureImage();
      case SuppPlatform.ios:
        return iOSCamera?.captureImage();
      default:
        throw UnsupportedError('Platform not supported');
    }
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
    final camera = androidCamera;
    if (camera is! AndroidCamera) return const SizedBox.shrink();

    final controller = camera.controller;
    if (controller == null) return const SizedBox.shrink();

    return controller.buildPreview();
  }

  /// Placeholder for building the camera preview widget for mobile platforms.
  ///
  /// This method should be implemented to return the camera preview for Android and iOS.
  Widget _buildIosPreview() {
    final camera = iOSCamera;
    if (camera is! IOSCamera) return const SizedBox.shrink();

    final controller = camera.controller;
    if (controller == null) return const SizedBox.shrink();

    return controller.buildPreview();
  }
}
