import 'package:universal_html/html.dart' as html show window;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/models/camera_description/camera_description.dart';
import 'src/models/enums/supported_platforms.dart';
import 'src/platforms/cameras_platform_interface.dart';

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
    final mediaDevices = html.window.navigator.mediaDevices;
    if (mediaDevices != null) {
      final cameraStream = await mediaDevices.getUserMedia({'video': {}});
      cameraStream.getAudioTracks().forEach((track) => track.stop());

      final devices = await mediaDevices.enumerateDevices();
      final videoDevices = devices.where((device) {
        return device.kind == 'videoinput';
      }).toList();

      return videoDevices
          .map((device) => CameraDescription.fromJs(videoDevices, device))
          .toList();
    } else {
      return [];
    }
  }
}
// MediaDeviceInfo ([object InputDeviceInfo])