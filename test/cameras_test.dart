import 'package:cameras/src/models/camera_description/camera_description.dart';
import 'package:cameras/src/models/enums/supported_platforms.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cameras/src/cameras.dart';
import 'package:cameras/src/platforms/cameras_platform_interface.dart';
import 'package:cameras/src/platforms/cameras_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCamerasPlatform
    with MockPlatformInterfaceMixin
    implements CamerasPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<CameraDescription>> getAvailableCameras() {
    throw UnimplementedError();
  }

  @override
  Future<SuppPlatform> getPlatformType() {
    throw UnimplementedError();
  }
}

void main() {
  final CamerasPlatform initialPlatform = CamerasPlatform.instance;

  test('$MethodChannelCameras is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCameras>());
  });

  test('getPlatformVersion', () async {
    Cameras camerasPlugin = Cameras();
    MockCamerasPlatform fakePlatform = MockCamerasPlatform();
    CamerasPlatform.instance = fakePlatform;

    expect(await camerasPlugin.getPlatformVersion(), '42');
  });
}
