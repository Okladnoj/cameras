import 'dart:async';
import 'dart:convert';
import 'package:universal_html/html.dart' as html
    show
        MediaStream,
        window,
        VideoElement,
        CanvasElement,
        CanvasRenderingContext2D;

import 'package:flutter/services.dart';

import '../../../../a_cameras.dart';
import '../../platforms/interfaces/camera_interface.dart';
import '../../utils/logger/logger_web.dart';

/// Represents the web implementation of the [CameraInterface].
/// Provides methods to interact with the camera on a web platform.
class WebCamera implements CameraInterface {
  html.MediaStream? _cameraStream;

  /// Initializes the camera based on the provided [cameraDescription].
  ///
  /// Throws an [Exception] if media devices are not available on the web platform.
  @override
  Future<void> initializeCamera(CameraDescription cameraDescription) async {
    final navigator = html.window.navigator;
    if (navigator.mediaDevices != null) {
      final constraints = {
        'video': {'deviceId': cameraDescription.id}
      };
      loggerWeb.e('constraints: $constraints');
      await stopStream();

      _cameraStream = await navigator.mediaDevices!.getUserMedia(constraints);
      loggerWeb.e('end constraints: $constraints');
      await Future.delayed(const Duration(milliseconds: 150));
    } else {
      loggerWeb.e('Exception(Media devices are not available)');
      throw Exception('Media devices are not available');
    }
  }

  /// Starts the camera stream.
  ///
  /// For the web platform, the stream starts automatically after initialization.
  @override
  Future<void> startStream() async {
    // For the web platform, the stream starts automatically upon initialization.
    // Therefore, there might not be any specific actions required here.
  }

  /// Stops the camera stream.
  ///
  /// Releases all resources associated with the stream.
  @override
  Future<void> stopStream() async {
    _cameraStream?.getTracks().forEach((track) {
      track.stop();
    });
    _cameraStream = null;
  }

  @override
  Future<Uint8List?> captureImage([dynamic element]) async {
    final videoElement = element;

    if (videoElement is! html.VideoElement) return null;

    final width = videoElement.videoWidth;
    final height = videoElement.videoHeight;

    final canvas = html.CanvasElement()
      ..width = width
      ..height = height;

    final ctx = canvas.getContext('2d') as html.CanvasRenderingContext2D;
    ctx.drawImage(videoElement, 0, 0);

    final completer = Completer<Uint8List>();

    final dataUrl = canvas.toDataUrl('image/jpeg');
    final base64String = dataUrl.split(',').last;
    final uint8List = base64.decode(base64String);
    completer.complete(uint8List);

    final future = await completer.future;
    return future;
  }

  /// Returns the current camera stream.
  ///
  /// This can be used to attach the stream to a video element or other media elements.
  html.MediaStream? get currentStream => _cameraStream;

  // You might want to add more methods or properties depending on your specific use-case.
}
