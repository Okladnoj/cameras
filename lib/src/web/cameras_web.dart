import 'package:universal_html/html.dart' as html show window, Navigator;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../platforms/interfaces/camera_controller.dart';
import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';

import '../platforms/interfaces/cameras_platform_interface.dart';
import '../utils/logger/logger_web.dart';
import 'controller_web.dart';

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
  Future<List<CameraDescription>> getAvailableCameras([
    bool back = true,
  ]) async {
    List<CameraDescription> availableCameras = [];
    try {
      final userAgent = html.window.navigator.userAgent.toLowerCase();

      if (RegExp(r'android').hasMatch(userAgent)) {
        await _navigatorAndroidRequestPermissions();
        await Future.delayed(const Duration(milliseconds: 150));
        await _requestAndroidPermissionsForAllCameras();
      } else {
        await _navigatorRequestPermissions(back);
        await Future.delayed(const Duration(milliseconds: 150));
        await _requestPermissionsForAllCameras(back);
      }
      final mediaDevices = _navigator.mediaDevices;
      if (mediaDevices == null) {
        loggerWeb.e(
            'MediaDevices is null. The browser might not support this feature.');
        return [];
      }

      final devices = await mediaDevices.enumerateDevices();

      final videoDevices =
          devices.where((device) => device.kind == 'videoinput').toList();

      // Map the list of video input devices to a list of CameraDescription objects.

      availableCameras = videoDevices
          .map((device) => CameraDescription.fromJs(videoDevices, device))
          .toSet()
          .toList();

      loggerWeb.e('availableCameras = > $availableCameras');
    } catch (error) {
      loggerWeb.e('An error occurred while getting available cameras: $error');
    }
    return availableCameras;
  }

  @override
  Future<CameraController> getCameraController() async {
    final platform = await getPlatformType();
    return ControllerWeb.init(platform);
  }

  Future<void> _navigatorAndroidRequestPermissions() async {
    try {
      // Request access to the camera, making the constraints less strict.

      final cameraStream = await _navigator.getUserMedia(
        video: true,
        audio: false,
      );

      // Stop any audio tracks if they have been started
      cameraStream.getAudioTracks().forEach((track) => track.stop());
    } catch (e) {
      loggerWeb.e('Error accessing camera: $e');
    }
  }

  Future<void> _navigatorRequestPermissions(bool back) async {
    try {
      // Request access to the camera, making the constraints less strict.
      final cameraStream = await _navigator.getUserMedia(
        video: {
          'facingMode': back ? 'environment' : 'user',
        },
        audio: false,
      );

      // Stop any audio tracks if they have been started
      cameraStream.getAudioTracks().forEach((track) => track.stop());
    } catch (e) {
      loggerWeb.e('Error accessing camera: $e');
    }
  }

  Future<void> _requestPermissionsForAllCameras(bool back) async {
    try {
      final mediaDevices = _navigator.mediaDevices;
      if (mediaDevices != null) {
        final cameraStream = await mediaDevices.getUserMedia({
          'video': {
            'facingMode': back ? 'environment' : 'user',
          },
          'audio': false,
        });
        cameraStream.getAudioTracks().forEach((track) => track.stop());
      }
    } catch (e) {
      loggerWeb.e('Error requesting permissions for all cameras: $e');
    }
  }

  Future<void> _requestAndroidPermissionsForAllCameras() async {
    try {
      final mediaDevices = _navigator.mediaDevices;
      if (mediaDevices != null) {
        final cameraStream = await mediaDevices.getUserMedia({
          'video': true,
          'audio': false,
        });
        cameraStream.getAudioTracks().forEach((track) => track.stop());
      }
    } catch (e) {
      loggerWeb.e('Error requesting permissions for all cameras: $e');
    }
  }
}
