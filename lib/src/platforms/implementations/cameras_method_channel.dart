import 'package:camera/camera.dart' as camera;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../cameras.dart';
import '../../models/camera_description/camera_description.dart';
import '../../models/enums/supported_platforms.dart';
import '../../utils/extensions/extensions.dart';
import '../../utils/logger/services/logger_service.dart';
import '../interfaces/camera_controller.dart';
import '../interfaces/cameras_platform_interface.dart';
import 'controller_mobile.dart';

class MethodChannelCameras extends CamerasPlatform {
  final methodChannel = const MethodChannel('cameras');

  @override
  Future<String?> getPlatformVersion() async {
    ls = await LoggerService.instance;
    final version = await iMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<SuppPlatform> getPlatformType() async {
    if (kIsWeb) return SuppPlatform.web;

    final platformName = await iMethod<String>('getPlatformType');

    switch (platformName) {
      case 'android':
        return SuppPlatform.android;
      case 'ios':
        return SuppPlatform.ios;
      default:
        throw UnsupportedError('Platform not recognized');
    }
  }

  @override
  Future<List<CameraDescription>> getAvailableCameras([
    bool back = true,
  ]) async {
    final platformName = await getPlatformType();
    switch (platformName) {
      case SuppPlatform.android:
        return _getAndroidCameras();

      case SuppPlatform.ios:
        return _getIosCameras();
      default:
        throw UnsupportedError('Platform not recognized');
    }
  }

  @override
  Future<CameraController> getCameraController() async {
    final platform = await getPlatformType();
    return ControllerMobile.init(platform);
  }

  Future<List<CameraDescription>> _getAndroidCameras() async {
    final cameras = await camera.availableCameras();
    return [...cameras.map(CameraDescription.fromHelpLib)];
  }

  Future<List<CameraDescription>> _getIosCameras() async {
    final cameras = await camera.availableCameras();
    return [...cameras.map(CameraDescription.fromHelpLib)];
  }
}
