import 'dart:typed_data';

import 'package:flutter/material.dart';

class PicturePage extends StatelessWidget {
  final Uint8List imageBytes;

  const PicturePage({
    super.key,
    required this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: InteractiveViewer(
          minScale: 0.1,
          maxScale: 5.0,
          child: Image.memory(imageBytes),
        ),
      ),
    );
  }
}
