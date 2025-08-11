// Conditional import to avoid dart:io on web
import 'logger_stub.dart' if (dart.library.io) 'logger_mobile_io.dart';

final loggerMobile = loggerStub;
