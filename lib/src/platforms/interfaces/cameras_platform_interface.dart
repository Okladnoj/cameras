import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'camera_controller.dart';
import '../../models/camera_description/camera_description.dart';
import '../../models/enums/supported_platforms.dart';
import '../implementations/cameras_method_channel.dart';

abstract class CamerasPlatform extends PlatformInterface {
  CamerasPlatform() : super(token: _token);

  static final Object _token = Object();

  static CamerasPlatform _instance = MethodChannelCameras();

  static CamerasPlatform get instance => _instance;

  static set instance(CamerasPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion();

  Future<SuppPlatform> getPlatformType();

  Future<List<CameraDescription>> getAvailableCameras([bool back = true]);

  Future<CameraController> getCameraController();
}
