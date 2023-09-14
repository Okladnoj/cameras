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

class Cameras {
  CamerasPlatform get _instance => CamerasPlatform.instance;

  Future<String?> getPlatformVersion() {
    return _instance.getPlatformVersion();
  }

  Future<List<CameraDescription>> getAvailableCameras() {
    return _instance.getAvailableCameras();
  }

  Future<CameraController> getCameraController() async {
    final platform = await _instance.getPlatformType();
    return CameraController._(platform);
  }
}
