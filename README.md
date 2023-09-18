# Cameras Plugin

A Flutter plugin for accessing camera features across multiple platforms with a single unified API. Currently supports Web platform, with more platforms coming soon.

## Features

- Access camera streams
- Capture images
- Switch between available cameras
- Unified API across platforms

## Installation

Add the following to your `pubspec.yaml` file:

```
dependencies:
  a_cameras: ^1.0.2
```

Then run `flutter pub get`.

## Platform Specific Configuration

### iOS

Before using this plugin on iOS, you need to update your `Info.plist` file with permission descriptions for camera and microphone access. These keys are required for iOS applications that access the camera or microphone. 

Add the following keys to your `ios/Runner/Info.plist`:

- `Privacy - Camera Usage Description`: Provide a message describing why your app needs access to the camera. 
- `Privacy - Microphone Usage Description`: Provide a message describing why your app needs access to the microphone.

Here is how you can add them in text format:

```
<key>NSCameraUsageDescription</key>
<string>your usage description here</string>
<key>NSMicrophoneUsageDescription</key>
<string>your usage description here</string>
```

### Android

For Android, you'll need to ensure that the minimum SDK version is set to 21 or higher. This is required for the plugin to work correctly.

Update your `android/app/build.gradle` file with the following:

```
minSdkVersion 21
```


## Usage

### Initialize the Camera

First, import the package and initialize the camera.

```dart
import 'package:a_cameras/a_cameras.dart';

final camerasPlugin = Cameras();
List<CameraDescription> availableCameras = await camerasPlugin.getAvailableCameras();
CameraController controller = await camerasPlugin.getCameraController();
await controller.initializeCamera(availableCameras.first);
```

### Start/Stop Camera Stream

You can start and stop the camera stream using the following methods.

```dart
await controller.startStream();
await controller.stopStream();
```

### Capture an Image

To capture an image, use the following method.

```dart
Uint8List? imageBytes = await controller.captureImage();
```

### Switch Between Available Cameras

To switch between the available cameras, you can use your own logic. Here's a simple example:

```dart
Future<void> switchCamera() async {
  final newIndex = (currentCameraIndex + 1) % availableCameras.length;
  await controller.initializeCamera(availableCameras[newIndex]);
  setState(() {
    currentCameraIndex = newIndex;
  });
}
```

## Supported Platforms

- [x] Web
- [x] Android
- [x] iOS

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request if you have any improvements.

## License

MIT License.
