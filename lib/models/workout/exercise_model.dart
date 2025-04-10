import 'package:flutter/material.dart';
import 'package:notoro/core/utils/enums/app_enums.dart';

class ExerciseModel {
  final String name;
  final List<BodyPart> bodyParts;
  final IconData? icon;

  ExerciseModel(this.icon, {required this.name, required this.bodyParts});
}
