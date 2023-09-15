import 'dart:developer';

import 'package:universal_html/html.dart' as html show window, Navigator;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';
import '../platforms/cameras_platform_interface.dart';
import '../utils/logger/logger.dart';

class CamerasWeb extends CamerasPlatform {
  CamerasWeb();

  html.Navigator get _navigator => html.window.navigator;

  static void registerWith(Registrar registrar) {
    CamerasPlatform.instance = CamerasWeb();
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = _navigator.userAgent;
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
      await _navigatorRequestPermissions();
      await _mediaDevicesRequestPermissions();

      final mediaDevices = _navigator.mediaDevices;

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

  Future<void> _navigatorRequestPermissions() async {
    try {
      // Request the browser for access to the camera by calling getUserMedia.
      // This will trigger a permission request to the user.
      // To ensure only video is used, you can set audio: false.
      final cameraStream = await _navigator.getUserMedia(
        video: {
          'mandatory': {'minWidth': 1280, 'minHeight': 720, 'minFrameRate': 30},
          'optional': []
        },
        audio: false,
      );

      logger.w('cameraStream.id => ${cameraStream.id}');

      // Since we've specified audio: false, this step may not be necessary
      // But in case you decide to enable audio later, it's good to keep.
      cameraStream.getAudioTracks().forEach((track) => track.stop());

      logger.w('cameraStream => $cameraStream');
    } catch (e) {
      // Handle the error
      logger.e('Error accessing camera: $e');
    }
  }

  Future<void> _mediaDevicesRequestPermissions() async {
    try {
      // Request the browser for access to the camera by calling getUserMedia.
      // This will trigger a permission request to the user.
      // To ensure only video is used, you can set audio: false.

      final cameraStream = await _navigator.mediaDevices?.getUserMedia({
        'video': {
          'mandatory': {'minWidth': 1280, 'minHeight': 720, 'minFrameRate': 30},
          'optional': []
        },
        'audio': false,
      });

      // Since we've specified audio: false, this step may not be necessary
      // But in case you decide to enable audio later, it's good to keep.
      cameraStream?.getAudioTracks().forEach((track) => track.stop());
    } catch (e) {
      // Handle the error
      logger.e('Error accessing camera: $e');
    }
  }
}
