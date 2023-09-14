import 'package:json_annotation/json_annotation.dart';

import '../../models/enums/lens_direction.dart';

class LensDirectionConverter implements JsonConverter<LensDirection, String?> {
  const LensDirectionConverter();

  @override
  LensDirection fromJson(String? name) {
    return LensDirection.values.firstWhere(
      (element) => element.name == name,
      orElse: () => LensDirection.unknown,
    );
  }

  @override
  String toJson(LensDirection element) => element.name;
}
