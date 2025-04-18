import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/workout/body_part.dart';
import '../../models/workout/exercise_model.dart';

class ExerciseFactory {
  static List<ExerciseModel> getBaseExercises(BuildContext context) {
    return [
      ExerciseModel(
        name: AppLocalizations.of(context)!.benchPress,
        bodyParts: [BodyPart.chest, BodyPart.shoulders, BodyPart.arms],
        assetImagePath: 'assets/exercises/bench_press.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.deadlift,
        bodyParts: [BodyPart.back, BodyPart.legs],
        assetImagePath: 'assets/exercises/deadlift.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.suwnica,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/exercises/suwnica_lezac.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.modlitewnik,
        bodyParts: [BodyPart.arms],
        assetImagePath: 'assets/exercises/modlitewnik.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.pushUp,
        bodyParts: [BodyPart.chest, BodyPart.arms, BodyPart.shoulders],
        assetImagePath: 'assets/exercises/pushup.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.brzuszki,
        bodyParts: [BodyPart.abs],
        assetImagePath: 'assets/body_parts/abs.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.shoulderPress,
        bodyParts: [BodyPart.shoulders],
        assetImagePath: 'assets/body_parts/shoulders.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.squat,
        bodyParts: [BodyPart.legs],
        assetImagePath: 'assets/body_parts/legs.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.bentOverRow,
        bodyParts: [BodyPart.back, BodyPart.arms],
        assetImagePath: 'assets/body_parts/back.png',
        isCustom: false,
      ),
      ExerciseModel(
        name: AppLocalizations.of(context)!.pullUp,
        bodyParts: [BodyPart.back, BodyPart.arms],
        assetImagePath: 'assets/body_parts/back.png',
        isCustom: false,
      ),
    ];
  }
}
