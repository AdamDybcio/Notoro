import 'package:notoro/core/utils/strings/app_strings.dart';

import '../../models/workout/body_part.dart';
import '../../models/workout/exercise_model.dart';

class ExerciseFactory {
  static List<ExerciseModel> getBaseExercises() {
    return [
      ExerciseModel(
        name: AppStrings.benchPress,
        bodyParts: [BodyPart.chest, BodyPart.shoulders, BodyPart.arms],
        assetImagePath: 'assets/exercises/bench_press.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.deadlift,
        bodyParts: [BodyPart.back, BodyPart.legs],
        assetImagePath: 'assets/exercises/deadlift.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.suwnica,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/suwnica_lezac.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.modlitewnik,
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/modlitewnik.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.pushUp,
        bodyParts: [BodyPart.chest, BodyPart.arms, BodyPart.shoulders],
        assetImagePath: 'assets/exercises/pushup.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.brzuszki,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/body_parts/abs.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.shoulderPress,
        bodyParts: [BodyPart.shoulders],
        assetImagePath: 'assets/body_parts/shoulders.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.squat,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/body_parts/legs.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.bentOverRow,
        bodyParts: [BodyPart.back, BodyPart.arms],
        assetImagePath: 'assets/body_parts/back.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppStrings.pullUp,
        bodyParts: [BodyPart.back, BodyPart.arms],
        assetImagePath: 'assets/body_parts/back.png',
        isCustom: false,
      ),
    ];
  }
}
