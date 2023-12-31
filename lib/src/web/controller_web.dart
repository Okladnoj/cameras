import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';

import '../models/cameras/web_camera.dart';
import '../platforms/interfaces/camera_controller.dart';
import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';
import '../utils/logger/logger_web.dart';

/// Controller for managing camera functionalities.
///
/// This controller provides methods to interact with the camera based on the platform.
class ControllerWeb extends CameraController {
  html.VideoElement? _videoElement;

  /// Constructs a [ControllerWeb] for the given platform [p].

  ControllerWeb._({required super.platform, required super.camera});

  factory ControllerWeb.init(SuppPlatform platform) {
    return ControllerWeb._(platform: platform, camera: WebCamera());
  }

  /// Initializes the camera using the provided [cameraDescription].
  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    return camera.initializeCamera(cameraDescription);
  }

  /// Starts the camera stream for the current platform.
  @override
  Future<void> startStream() async {
    return camera.startStream();
  }

  /// Stops the camera stream for the current platform.
  @override
  Future<void> stopStream() async {
    return camera.stopStream();
  }

  /// Captures an image using the camera on the current platform.
  ///
  /// Returns a [Uint8List] that contains the image data.
  @override
  Future<Uint8List?> captureImage() async {
    return camera.captureImage(_videoElement);
  }

  /// Builds the camera preview widget based on the current platform.
  @override
  Widget buildPreview(BuildContext context) {
    switch (platform) {
      case SuppPlatform.web:
        return _buildWebPreview();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Builds the camera preview widget for web.
  Widget _buildWebPreview() {
    var camera = this.camera;
    if (camera is! WebCamera) return const SizedBox.shrink();

    _videoElement = _getVideoElement(camera);
    var videoElement = _videoElement;

    if (videoElement == null) return const SizedBox.shrink();

    var videoElementId =
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

  html.VideoElement _getVideoElement(WebCamera camera) {
    final userAgent = html.window.navigator.userAgent.toLowerCase();

    if (RegExp(r'android').hasMatch(userAgent)) {
      var videoElement = html.VideoElement()
        ..srcObject = camera.currentStream
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

      loggerWeb.e(videoElement);

      videoElement.addEventListener('click', (e) {
        e.preventDefault();
      });

      return videoElement;
    }

    var videoElement = html.VideoElement()
      ..srcObject = camera.currentStream
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

    return videoElement;
  }
}
