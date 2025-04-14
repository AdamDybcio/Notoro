import '../../models/workout/body_part.dart';
import '../../models/workout/exercise_model.dart';

class ExerciseFactory {
  static List<ExerciseModel> getBaseExercises() {
    return [
      ExerciseModel(
        name: 'Wyciskanie na ławce',
        bodyParts: [BodyPart.chest, BodyPart.shoulders, BodyPart.arms],
        assetImagePath: 'assets/exercises/bench_press.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Martwy ciąg',
        bodyParts: [BodyPart.back, BodyPart.legs],
        assetImagePath: 'assets/exercises/deadlift.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Wypychanie ciężaru na suwnicy',
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/suwnica_lezac.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Uginanie ramion na modlitewniku',
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/modlitewnik.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: 'Pompki',
        bodyParts: [BodyPart.chest, BodyPart.arms, BodyPart.shoulders],
        assetImagePath: 'assets/exercises/pushup.png',
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
