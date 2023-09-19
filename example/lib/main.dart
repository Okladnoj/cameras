import 'package:a_cameras/a_cameras.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'picture_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLogger();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _camerasPlugin = Cameras();

  List<CameraDescription> _list = [];
  CameraController? _controller;
  bool _loading = false;
  int _currentCameraIndex = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState([bool back = true]) async {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      ls?.showString(context);
    });

    setState(() {
      _loading = true;
    });
    final result = await _camerasPlugin.getAvailableCameras(back);
    _controller = await _camerasPlugin.getCameraController();
    if (result.isEmpty) {
      setState(() {
        _list = result;
        _loading = false;
      });
      return;
    }
    await _controller?.initializeCamera(result.first);

    setState(() {
      _list = result;
      _loading = false;
    });
  }

  Future<void> _switchCamera() async {
    if (_list.isEmpty) return _initPlatformState(false);

    final newIndex = (_currentCameraIndex + 1) % _list.length;
    ls?.setString('newIndex = > $newIndex');
    ls?.setString('_list = > $_list');
    await _controller?.initializeCamera(_list[newIndex]);

    setState(() {
      _currentCameraIndex = newIndex;
    });
  }

  Future<void> _captureImage(BuildContext context) async {
    final bytes = await _controller?.captureImage();
    if (bytes == null) return;

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PicturePage(imageBytes: bytes);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: [
            IconButton(
              icon: const Icon(Icons.switch_camera, size: 42),
              onPressed: _switchCamera,
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: Builder(builder: (context) {
          if (_loading) return const Center(child: CircularProgressIndicator());

          final contr = _controller;
          if (contr != null) return contr.buildPreview(context);

          return Center(child: Text('Running on: $_list\n'));
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (context) {
            return OutlinedButton(
              onPressed: () => _captureImage(context),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue.withOpacity(0.4),
                shape: const StadiumBorder(),
              ),
              child: const Icon(Icons.camera_alt, size: 64),
            );
          },
        ),
      ),
    );
  }
}
