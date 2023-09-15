import 'dart:developer';

import 'package:universal_html/html.dart' as html show window, Navigator;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';
import '../platforms/cameras_platform_interface.dart';

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
    List<CameraDescription> availableCameras = [];
    try {
      await _navigatorRequestPermissions();
      await Future.delayed(const Duration(milliseconds: 150));
      await _requestPermissionsForAllCameras();

      final mediaDevices = _navigator.mediaDevices;
      if (mediaDevices == null) {
        log('MediaDevices is null. The browser might not support this feature.');
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
    } catch (error) {
      log('An error occurred while getting available cameras: $error');
    }
    return availableCameras;
  }

  Future<void> _navigatorRequestPermissions() async {
    try {
      // Request access to the camera, making the constraints less strict.
      final cameraStream = await _navigator.getUserMedia(
        video: {
          'width': {'ideal': 1280},
          'height': {'ideal': 720}
        },
        audio: false,
      );

      // Stop any audio tracks if they have been started
      cameraStream.getAudioTracks().forEach((track) => track.stop());
    } catch (e) {
      log('Error accessing camera: $e');
    }
  }

  Future<void> _requestPermissionsForAllCameras() async {
    try {
      final mediaDevices = _navigator.mediaDevices;
      if (mediaDevices != null) {
        final devices = await mediaDevices.enumerateDevices();
        final videoDevices = devices.where((device) {
          return device.kind == 'videoinput';
        }).toList();

        for (var device in videoDevices) {
          await _navigator.getUserMedia(
            video: {'deviceId': device.deviceId},
            audio: false,
          );
        }
      }
    } catch (e) {
      log('Error requesting permissions for all cameras: $e');
    }
  }
}
