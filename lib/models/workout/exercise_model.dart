import 'package:notoro/models/workout/body_part.dart';

class ExerciseModel {
  final String name;
  final List<BodyPart> bodyParts;
  final String assetImagePath;

  ExerciseModel(
      {required this.name,
      required this.bodyParts,
      required this.assetImagePath});
}
