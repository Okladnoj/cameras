import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final loggerWeb = Logger(printer: CustomPrinter());

class CustomPrinter extends LogPrinter {
  final PrettyPrinter prettyPrinter = PrettyPrinter(lineLength: 120);

  @override
  List<String> log(LogEvent event) {
    final message = prettyPrinter.log(event);
    try {
      if (kIsWeb) {
        html.window.console.error('console.log ---> ${[message.join('\n')]}');
      }
    } catch (_) {}

    return message;
  }
}
