import 'dart:developer';

import 'package:universal_html/html.dart' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';
import '../platforms/cameras_platform_interface.dart';

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
      // Access the media devices from the browser's window.navigator object.
      final mediaDevices = html.window.navigator.mediaDevices;

      // Check if mediaDevices is not null. If it's null, then the browser might not support this feature.
      if (mediaDevices != null) {
        // Request the browser for access to the camera by calling getUserMedia.
        // This will trigger a permission request to the user.
        final cameraStream = await mediaDevices.getUserMedia({'video': {}});

        // After getting the stream, immediately stop any audio tracks if they exist.
        // This is done to ensure that only the video stream is active.
        cameraStream.getAudioTracks().forEach((track) => track.stop());

        // Enumerate all media devices. This will give us a list of all audio and video input devices.
        final devices = await mediaDevices.enumerateDevices();

        // Filter out only the video input devices from the list.
        final videoDevices = devices.where((device) {
          return device.kind == 'videoinput';
        }).toList();

        // Map the list of video input devices to a list of CameraDescription objects.
        return videoDevices
            .map((device) => CameraDescription.fromJs(videoDevices, device))
            .toList();
      } else {
        log('MediaDevices is null. The browser might not support this feature.');
        return [];
      }
    } catch (error) {
      log('An error occurred while getting available cameras: $error');
      return [];
    }
  }
}
