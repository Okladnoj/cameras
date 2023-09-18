import 'package:universal_html/html.dart' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';

import '../models/cameras/web_camera.dart';
import '../platforms/interfaces/camera_controller.dart';
import '../models/camera_description/camera_description.dart';
import '../models/enums/supported_platforms.dart';

/// Controller for managing camera functionalities.
///
/// This controller provides methods to interact with the camera based on the platform.
class ControllerWeb extends CameraController {
  /// Constructs a [ControllerWeb] for the given platform [p].

  ControllerWeb._({required super.platform, super.webCamera});

  factory ControllerWeb.init(SuppPlatform platform) {
    switch (platform) {
      case SuppPlatform.web:
        return ControllerWeb._(platform: platform, webCamera: WebCamera());
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Initializes the camera using the provided [cameraDescription].
  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.initializeCamera(cameraDescription);
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Starts the camera stream for the current platform.
  @override
  Future<void> startStream() async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.startStream();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Stops the camera stream for the current platform.
  @override
  Future<void> stopStream() async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.stopStream();
      default:
        throw UnsupportedError('Platform not supported');
    }
  }

  /// Captures an image using the camera on the current platform.
  ///
  /// Returns a [Uint8List] that contains the image data.
  @override
  Future<Uint8List?> captureImage() async {
    switch (platform) {
      case SuppPlatform.web:
        return webCamera?.captureImage();
      default:
        throw UnsupportedError('Platform not supported');
    }
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
    final webCamera = this.webCamera;
    if (webCamera is! WebCamera) return const SizedBox.shrink();

    final videoElement = html.VideoElement()
      ..srcObject = webCamera.currentStream
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
}
