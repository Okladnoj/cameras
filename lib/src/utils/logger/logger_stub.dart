// Stub logger implementation that doesn't import dart:io
class LoggerStub {
  void d(dynamic message) {}
  void i(dynamic message) {}
  void w(dynamic message) {}
  void e(dynamic message) {}
  void v(dynamic message) {}
  void wtf(dynamic message) {}
}

final loggerStub = LoggerStub();
