import 'package:cameras_example/picture_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cameras/cameras.dart';

void main() {
  runApp(const MyApp());
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

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    setState(() {
      _loading = true;
    });
    final result = await _camerasPlugin.getAvailableCameras();
    _controller = await _camerasPlugin.getCameraController();
    await _controller?.initializeCamera(result.first);

    setState(() {
      _list = result;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          if (_loading) return const Center(child: CircularProgressIndicator());
          print('$_list');

          final contr = _controller;
          if (contr != null) return contr.buildPreview(context);

          return Center(child: Text('Running on: $_list\n'));
        }),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(onPressed: () async {
            final bytes = await _controller?.captureImage();
            if (bytes == null) return;

            if (!mounted) return;

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return PicturePage(imageBytes: bytes);
              },
            ));
          });
        }),
      ),
    );
  }
}
