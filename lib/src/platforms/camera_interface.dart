import 'dart:typed_data';

import '../../cameras.dart';

abstract class CameraInterface {
  Future<void> initializeCamera(CameraDescription cameraDescription);

  Future<void> startStream();

  Future<void> stopStream();

  Future<Uint8List?> captureImage();
}
