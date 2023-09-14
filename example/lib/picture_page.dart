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
    return Scaffold(body: Center(child: Image.memory(imageBytes)));
  }
}
