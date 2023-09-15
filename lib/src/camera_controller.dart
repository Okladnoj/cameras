part of 'cameras.dart';

/// Controller for managing camera functionalities.
///
/// This controller provides methods to interact with the camera based on the platform.
class CameraController {
  /// The platform on which the app is currently running.
  final SuppPlatform platform;

  /// Instance of the web camera (if available).
  final WebCamera? webCamera;

  /// Instance of the Android camera (if available).
  final AndroidCamera? androidCamera;

  /// Instance of the iOS camera (if available).
  final IOSCamera? iOSCamera;

  /// Constructs a [CameraController] for the given platform [p].
  CameraController._(SuppPlatform p)
      : platform = p,
        webCamera = (p == SuppPlatform.web) ? WebCamera() : null,
        androidCamera = (p == SuppPlatform.android) ? AndroidCamera() : null,
        iOSCamera = (p == SuppPlatform.ios) ? IOSCamera() : null;

  /// Initializes the camera using the provided [cameraDescription].
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.initializeCamera(cameraDescription);
      case SuppPlatform.android:
        return androidCamera?.initializeCamera(cameraDescription);
      case SuppPlatform.ios:
        return iOSCamera?.initializeCamera(cameraDescription);
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Starts the camera stream for the current platform.
  Future<void> startStream() async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.startStream();
      case SuppPlatform.android:
        return androidCamera?.startStream();
      case SuppPlatform.ios:
        return iOSCamera?.startStream();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Stops the camera stream for the current platform.
  Future<void> stopStream() async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.stopStream();
      case SuppPlatform.android:
        return androidCamera?.stopStream();
      case SuppPlatform.ios:
        return iOSCamera?.stopStream();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Captures an image using the camera on the current platform.
  ///
  /// Returns a [Uint8List] that contains the image data.
  Future<Uint8List?> captureImage() async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.captureImage();
      case SuppPlatform.android:
        return androidCamera?.captureImage();
      case SuppPlatform.ios:
        return iOSCamera?.captureImage();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Builds the camera preview widget based on the current platform.
  Widget buildPreview(BuildContext context) {
    switch (platform) {
      case SuppPlatform.web:
        return _buildWebPreview();
      case SuppPlatform.android:
      case SuppPlatform.ios:
        return _buildMobilePreview();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Builds the camera preview widget for web.
  Widget _buildWebPreview() {
    final videoElement = html.VideoElement()
      ..srcObject = webCamera?.currentStream
      ..autoplay = true
      ..controls = false
      ..setAttribute('playsinline', 'true')
      ..style.position = 'absolute'
      ..style.minWidth = '100%'
      ..style.minHeight = '100%'
      ..style.width = 'auto'
      ..style.height = 'auto'
      ..style.top = '50%'
      ..style.left = '50%'
      ..style.pointerEvents = 'none'
      ..style.cursor = 'none'
      ..style.transform = 'translate(-50%, -50%)';

    videoElement.addEventListener('click', (e) {
      e.preventDefault();
    });

    final videoElementId =
        'camera-preview-${DateTime.now().millisecondsSinceEpoch}';
    videoElement.id = videoElementId;

    var body = html.document.body;
    if (body == null) return const SizedBox.shrink();
    body.children.add(videoElement);

    ui.platformViewRegistry.registerViewFactory(
      videoElementId,
      (int viewId) => videoElement,
    );

    return HtmlElementView(
      key: UniqueKey(),
      viewType: videoElementId,
    );
  }

  /// Placeholder for building the camera preview widget for mobile platforms.
  ///
  /// This method should be implemented to return the camera preview for Android and iOS.
  Widget _buildMobilePreview() {
    return Container();
  }
}
