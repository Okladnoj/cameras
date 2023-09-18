import 'platforms/interfaces/camera_controller.dart';
import 'models/camera_description/camera_description.dart';
import 'platforms/interfaces/cameras_platform_interface.dart';

/// Main class for the `cameras` plugin.
///
/// Provides methods to interact with the camera on different platforms.
class Cameras {
  /// Gets the current instance of [CamerasPlatform].
  CamerasPlatform get _instance => CamerasPlatform.instance;

  /// Fetches the platform version.
  ///
  /// Returns a string representation of the platform version.
  Future<String?> getPlatformVersion() {
    return _instance.getPlatformVersion();
  }

  /// Fetches the list of available cameras.
  ///
  /// Returns a list of [CameraDescription] that describes each available camera on the platform.
  ///
  /// [bool back = true] - Request started with Back Camera
  ///
  Future<List<CameraDescription>> getAvailableCameras([bool back = true]) {
    return _instance.getAvailableCameras(back);
  }

  /// Creates and returns a [CameraController] for controlling camera actions.
  ///
  /// The returned controller will be specific to the current platform (e.g., Android, iOS, Web).
  Future<CameraController> getCameraController() {
    return _instance.getCameraController();
  }
}
