import '../../platforms/implementations/cameras_method_channel.dart';

extension MethodChannelCamerasExt on MethodChannelCameras {
  Future<T?> iMethod<T>(String method, [dynamic arguments]) {
    return methodChannel.invokeMethod(method, arguments);
  }
}

extension IterableExt on Iterable? {
  Iterable<T> pars<T>(T Function(Map<String, dynamic>) function) {
    return (this ?? []).whereType<Map<String, dynamic>>().map(function);
  }
}
