# Cameras Plugin

A Flutter plugin for accessing camera features across multiple platforms with a single unified API. Currently supports Web platform, with more platforms coming soon.

## Features

- Access camera streams
- Capture images
- Unified API across platforms

## Installation

Add the following to your `pubspec.yaml` file:

```
dependencies:
  cameras: ^0.0.1
```

Then run `flutter pub get`.

## Usage

1. **Initialize the camera**:

```dart
import 'package:cameras/cameras.dart';

final camerasPlugin = Cameras();

List<CameraDescription> availableCameras = await camerasPlugin.getAvailableCameras();
CameraController controller = await camerasPlugin.getCameraController();
await controller.initializeCamera(availableCameras.first);
```

2. **Start/Stop Camera Stream**:

```dart
await controller.startStream();
await controller.stopStream();
```

3. **Capture an image**:

```dart
Uint8List? imageBytes = await controller.captureImage();
```

## Supported Platforms

- [x] Web
- [ ] Android (Coming Soon)
- [ ] iOS (Coming Soon)

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request if you have any improvements.

## License

MIT License.
