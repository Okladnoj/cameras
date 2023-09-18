import 'package:logger/logger.dart';

final loggerMobile = Logger(printer: CustomPrinter());

class CustomPrinter extends LogPrinter {
  final PrettyPrinter prettyPrinter = PrettyPrinter(lineLength: 120);

  @override
  List<String> log(LogEvent event) {
    final message = prettyPrinter.log(event);

    return message;
  }
}
