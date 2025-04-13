import '../../models/workout/body_part.dart';
import '../../models/workout/exercise_model.dart';

class ExerciseFactory {
  static List<ExerciseModel> getBaseExercises() {
    return [
      ExerciseModel(
        name: 'Wyciskanie na ławce',
        bodyParts: [BodyPart.chest],
        assetImagePath: 'assets/exercises/bench_press.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Martwy ciąg',
        bodyParts: [BodyPart.back, BodyPart.legs],
        assetImagePath: 'assets/body_parts/back.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Przysiady',
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/body_parts/legs.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Podciąganie',
        bodyParts: [BodyPart.back, BodyPart.arms],
        assetImagePath: 'assets/body_parts/biceps.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Pompki',
        bodyParts: [BodyPart.chest, BodyPart.arms, BodyPart.shoulders],
        assetImagePath: 'assets/body_parts/chest.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Brzuszki',
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/body_parts/abs.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Wyciskanie hantli nad głowę',
        bodyParts: [BodyPart.shoulders],
        assetImagePath: 'assets/body_parts/shoulders.png',
        isCustom: false,
      ),
    ];
  }
}
