import 'dart:developer';

import 'package:universal_html/html.dart' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';
import '../platforms/cameras_platform_interface.dart';
import '../utils/logger/logger.dart';

class CamerasWeb extends CamerasPlatform {
  CamerasWeb();

  static void registerWith(Registrar registrar) {
    CamerasPlatform.instance = CamerasWeb();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return 'WEB: $version';
  }

  @override
  Future<SuppPlatform> getPlatformType() async {
    return SuppPlatform.web;
  }

  @override
  Future<List<CameraDescription>> getAvailableCameras() async {
    try {
      // Check if mediaDevices is not null. If it's null, then the browser might not support this feature.
      try {
        // Request the browser for access to the camera by calling getUserMedia.
        // This will trigger a permission request to the user.
        final cameraStream =
            await html.window.navigator.getUserMedia(video: true);

        logger.w('cameraStream.id => ${cameraStream.id}');

        // After getting the stream, immediately stop any audio tracks if they exist.
        // This is done to ensure that only the video stream is active.
        cameraStream.getAudioTracks().forEach((track) => track.stop());

        logger.w('cameraStream => $cameraStream');
      } catch (_) {}

      final mediaDevices = html.window.navigator.mediaDevices;

      if (mediaDevices == null) {
        log('MediaDevices is null. The browser might not support this feature.');
        return [];
      }

      // Enumerate all media devices. This will give us a list of all audio and video input devices.
      final devices = await mediaDevices.enumerateDevices();

      logger.w('devices => $devices');

      // Filter out only the video input devices from the list.
      final videoDevices = devices.where((device) {
        return device.kind == 'videoinput';
      }).toList();

      logger.w('videoDevices => $videoDevices');

      // Map the list of video input devices to a list of CameraDescription objects.
      return videoDevices
          .map((device) => CameraDescription.fromJs(videoDevices, device))
          .toList();
    } catch (error) {
      log('An error occurred while getting available cameras: $error');
      return [];
    }
  }
}
