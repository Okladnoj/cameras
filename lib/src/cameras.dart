import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';

import 'models/camera_description/camera_description.dart';
import 'models/enums/supported_platforms.dart';
import 'platforms/cameras_platform_interface.dart';
import 'platforms/implementations/android_camera.dart';
import 'platforms/implementations/ios_camera.dart';
import 'platforms/implementations/web_camera.dart';

part 'camera_controller.dart';

/// Main class for the `cameras` plugin.
///
/// Provides methods to interact with the camera on different platforms.
class Cameras {
  /// Gets the current instance of [CamerasPlatform].
  CamerasPlatform get _instance => CamerasPlatform.instance;

  /// Fetches the platform version.
  ///
  /// Returns a string representation of the platform version.
  Future<String?> getPlatformVersion() {
    return _instance.getPlatformVersion();
  }

  /// Fetches the list of available cameras.
  ///
  /// Returns a list of [CameraDescription] that describes each available camera on the platform.
  Future<List<CameraDescription>> getAvailableCameras() {
    return _instance.getAvailableCameras();
  }

  /// Creates and returns a [CameraController] for controlling camera actions.
  ///
  /// The returned controller will be specific to the current platform (e.g., Android, iOS, Web).
  Future<CameraController> getCameraController() async {
    final platform = await _instance.getPlatformType();
    return CameraController._(platform);
  }
}
