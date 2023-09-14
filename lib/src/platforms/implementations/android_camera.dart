import 'dart:developer';

import 'package:flutter/services.dart';

import '../../../a_cameras.dart';
import '../camera_interface.dart';

class AndroidCamera implements CameraInterface {
  final MethodChannel _channel;

  AndroidCamera() : _channel = const MethodChannel('android_camera');

  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    try {
      await _channel.invokeMethod('initializeCamera', {
        'cameraId': cameraDescription.id,
        // ... Other parameters if needed
      });
    } on PlatformException catch (e) {
      log('Error initializing camera: ${e.message}');
    }
  }

  @override
  Future<void> startStream() async {
    try {
      await _channel.invokeMethod('startStream');
    } on PlatformException catch (e) {
      log('Error starting stream: ${e.message}');
    }
  }

  @override
  Future<void> stopStream() async {
    try {
      await _channel.invokeMethod('stopStream');
    } on PlatformException catch (e) {
      log('Error stopping stream: ${e.message}');
    }
  }

  @override
  Future<Uint8List?> captureImage() async {
    try {
      final bytes = await _channel.invokeMethod<Uint8List>('captureImage');
      return bytes;
    } on PlatformException catch (e) {
      log('Error capturing image: ${e.message}');
      return null;
    }
  }
}
