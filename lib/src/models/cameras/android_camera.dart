import 'package:flutter/services.dart';
import 'package:camera/camera.dart' as camera;

import '../../../../a_cameras.dart';
import '../../platforms/interfaces/camera_interface.dart';
import '../../utils/logger/logger_mobile.dart';

class AndroidCamera implements CameraInterface {
  camera.CameraController? _controller;

  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    try {
      _controller = camera.CameraController(
        cameraDescription.toHelpLib,
        camera.ResolutionPreset.max,
      );
      await _controller?.initialize();
    } on PlatformException catch (e) {
      loggerMobile.e('Error initializing camera: ${e.message}');
    }
  }

  @override
  Future<void> startStream() async {
    try {} on PlatformException catch (e) {
      loggerMobile.e('Error starting stream: ${e.message}');
    }
  }

  @override
  Future<void> stopStream() async {
    try {} on PlatformException catch (e) {
      loggerMobile.e('Error stopping stream: ${e.message}');
    }
  }

  @override
  Future<Uint8List?> captureImage() async {
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
