import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';
import '../utils/extensions/extensions.dart';
import 'cameras_platform_interface.dart';

class MethodChannelCameras extends CamerasPlatform {
  final methodChannel = const MethodChannel('cameras');

  @override
  Future<String?> getPlatformVersion() async {
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
    final result = await iMethod<List<dynamic>>('getAvailableCameras');

    return result.pars(CameraDescription.fromJson).toList();
  }
}
