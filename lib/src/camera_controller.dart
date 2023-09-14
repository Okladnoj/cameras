part of 'cameras.dart';

class CameraController {
  final SuppPlatform platform;
  final WebCamera? webCamera;
  final AndroidCamera? androidCamera;
  final IOSCamera? iOSCamera;

  CameraController._(SuppPlatform p)
      : platform = p,
        webCamera = (p == SuppPlatform.web) ? WebCamera() : null,
        androidCamera = (p == SuppPlatform.android) ? AndroidCamera() : null,
        iOSCamera = (p == SuppPlatform.ios) ? IOSCamera() : null;

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

  Widget _buildWebPreview() {
    final videoElement = html.VideoElement()
      ..srcObject = webCamera?.currentStream
      ..autoplay = true
      ..controls = false
      ..style.position = 'absolute'
      ..style.minWidth = '100%'
      ..style.minHeight = '100%'
      ..style.width = 'auto'
      ..style.height = 'auto'
      ..style.top = '50%'
      ..style.left = '50%'
      ..style.transform = 'translate(-50%, -50%)';

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

  Widget _buildMobilePreview() {
    return Container();
  }
}
