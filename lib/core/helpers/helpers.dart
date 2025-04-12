import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/core/utils/enums/app_enums.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

import '../../controllers/workout_builder/workout_builder_bloc.dart';

class Helpers {
  static String mapBodyPartToString(BodyPart part) {
    switch (part) {
      case BodyPart.chest:
        return 'assets/body_parts/chest.png';
      case BodyPart.back:
        return 'assets/body_parts/back.png';
      case BodyPart.legs:
        return 'assets/body_parts/legs.png';
      case BodyPart.arms:
        return 'assets/body_parts/biceps.png';
      case BodyPart.shoulders:
        return 'assets/body_parts/shoulders.png';
      case BodyPart.abs:
        return 'assets/body_parts/abs.png';
    }
  }

  static String mapBodyPartToName(BodyPart part) {
    switch (part) {
      case BodyPart.chest:
        return 'Klatka';
      case BodyPart.back:
        return 'Plecy';
      case BodyPart.legs:
        return 'Nogi';
      case BodyPart.arms:
        return 'Ramiona';
      case BodyPart.shoulders:
        return 'Barki';
      case BodyPart.abs:
        return 'Brzuch';
    }
  }

  static Future<bool?> showDeleteConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String confirmText,
    required bool isNegative,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isNegative ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  static void showEditSetDialog({
    required BuildContext context,
    required int index,
    required ExerciseTrainingModel exercise,
    required int exerciseIndex,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        final repsController =
            TextEditingController(text: exercise.reps[index].toString());
        final weightController =
            TextEditingController(text: exercise.weight[index].toString());

        return AlertDialog(
          title: const Text(AppStrings.editSet),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: repsController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  labelText: AppStrings.reps,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(50),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d*'),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: AppStrings.weight,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withAlpha(50),
                ),
              ),
              if (exercise.sets > 1)
                TextButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    final updatedReps = List<int>.from(exercise.reps)
                      ..removeAt(index);
                    final updatedWeight = List<double>.from(exercise.weight)
                      ..removeAt(index);
                    context.read<WorkoutBuilderBloc>().add(
                          UpdateFullExercise(
                            exerciseIndex: exerciseIndex,
                            newSets: updatedReps.length,
                            newReps: updatedReps,
                            newWeight: updatedWeight,
                          ),
                        );
                    Navigator.of(ctx).pop();
                  },
                  label: const Text('Usuń serię'),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                final newReps = int.tryParse(repsController.text) ?? 8;
                final newWeight = double.tryParse(weightController.text) ?? 0;
                context.read<WorkoutBuilderBloc>().add(
                      UpdateExerciseSet(
                        exerciseIndex: exerciseIndex,
                        setIndex: index,
                        newReps: newReps,
                        newWeight: newWeight,
                      ),
                    );
                Navigator.of(ctx).pop();
              },
              child: const Text(AppStrings.save),
            ),
          ],
        );
      },
    );
  }
}
