import 'package:flutter/material.dart';
import 'package:notoro/core/utils/enums/app_enums.dart';

class Helpers {
  static IconData mapBodyPartToIcon(BodyPart part) {
    switch (part) {
      case BodyPart.chest:
        return Icons.favorite_border;
      case BodyPart.legs:
        return Icons.directions_walk;
      case BodyPart.back:
        return Icons.fitness_center;
      case BodyPart.shoulders:
        return Icons.accessibility_new;
      case BodyPart.arms:
        return Icons.pan_tool_alt_outlined;
      default:
        return Icons.circle;
    }
  }
}
