import 'package:json_annotation/json_annotation.dart';

class NumConverter<T extends num> implements JsonConverter<List<T>, List<T?>> {
  const NumConverter();

  @override
  List<T> fromJson(List<T?> string) {
    return [
      ...string.whereType<T>(),
    ];
  }

  @override
  List<T> toJson(List<T> dates) {
    return dates;
  }
}
