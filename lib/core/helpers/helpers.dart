import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/active_workout/workout_session_controller.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_bloc.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_event.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/dashboard/weekly_plan.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:notoro/views/workout/widgets/body_part_chip.dart';

import '../../controllers/workout_builder/workout_builder_bloc.dart';
import '../../models/workout/body_part.dart';

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

  static String mapDayOfWeekToName(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.monday:
        return 'Poniedziałek';
      case DayOfWeek.tuesday:
        return 'Wtorek';
      case DayOfWeek.wednesday:
        return 'Środa';
      case DayOfWeek.thursday:
        return 'Czwartek';
      case DayOfWeek.friday:
        return 'Piątek';
      case DayOfWeek.saturday:
        return 'Sobota';
      case DayOfWeek.sunday:
        return 'Niedziela';
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

  static Color mapBodyPartToColor(BodyPart part) {
    switch (part) {
      case BodyPart.chest:
        return Colors.redAccent;
      case BodyPart.back:
        return Colors.blueAccent;
      case BodyPart.legs:
        return Colors.green;
      case BodyPart.arms:
        return Colors.orange;
      case BodyPart.shoulders:
        return Colors.purple;
      case BodyPart.abs:
        return Colors.teal;
    }
  }

  static DayOfWeek getTodayEnum() {
    final weekday = DateTime.now().weekday;
    return DayOfWeek.values[weekday - 1];
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

  static void showEditSetDialogWorkout({
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
                    context.read<WorkoutDetailBloc>().add(
                          RemoveSetFromExerciseFromDetail(
                            exerciseIndex: exerciseIndex,
                            setIndex: index,
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
                context.read<WorkoutDetailBloc>().add(
                      UpdateExerciseSetFromDetail(
                        exerciseIndex: exerciseIndex,
                        setIndex: index,
                        reps: newReps,
                        weight: newWeight,
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

  static Future<int?> showWorkoutPickerDialog({
    required BuildContext context,
    required Map<int, WorkoutModel> availableWorkouts,
  }) {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(AppStrings.chooseWorkout),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () => Navigator.pop(context, null),
                tileColor: Theme.of(context).colorScheme.primaryContainer,
                title: const Text(AppStrings.clearDay),
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.clear,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: availableWorkouts.entries
                        .map((entry) {
                          return Column(
                            children: [
                              ListTile(
                                onTap: () => Navigator.pop(context, entry.key),
                                title: Text(entry.value.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${entry.value.exercises.length} ćwiczeń',
                                    ),
                                    const SizedBox(height: 4),
                                    Wrap(
                                      spacing: 4,
                                      runSpacing: 4,
                                      children: [
                                        ...entry.value.exercises.take(5).map(
                                              (exercise) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: exercise
                                                            .assetImagePath !=
                                                        ''
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Image.asset(
                                                          exercise
                                                              .assetImagePath,
                                                          width: 18,
                                                          height: 18,
                                                        ),
                                                      )
                                                    : Icon(
                                                        Icons.fitness_center,
                                                        size: 18,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimaryContainer,
                                                      ),
                                              ),
                                            ),
                                        if (entry.value.exercises.length > 5)
                                          Text(
                                            '+${entry.value.exercises.length - 5}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimaryContainer,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                leading: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    Icons.fitness_center,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        })
                        .toList()
                        .reversed
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static void showEditSetDialogOnSession(
    BuildContext context,
    WorkoutSessionController controller,
    int setIndex,
  ) {
    final ex = controller.currentExerciseModel;
    final repsController =
        TextEditingController(text: ex.reps[setIndex].toString());
    final weightController =
        TextEditingController(text: ex.weight[setIndex].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              final reps =
                  int.tryParse(repsController.text) ?? ex.reps[setIndex];
              final weight =
                  double.tryParse(weightController.text) ?? ex.weight[setIndex];

              controller.editSet(setIndex, reps, weight);
              Navigator.pop(context);
            },
            child: const Text(AppStrings.save),
          )
        ],
      ),
    );
  }

  static List<ExerciseTrainingModel> filterValidExercises(
      HistoryModel history) {
    if (!history.wasAbandoned) return history.exercises;

    return history.exercises
        .asMap()
        .entries
        .map((entry) {
          final exIndex = entry.key;
          final ex = entry.value;

          if (exIndex < history.interruptedExerciseIndex!) {
            return ex;
          }

          if (exIndex == history.interruptedExerciseIndex) {
            final validSets = history.interruptedSetIndex!;
            if (validSets == 0) return null;
            return ExerciseTrainingModel(
              name: ex.name,
              bodyParts: ex.bodyParts.take(validSets).toList(),
              assetImagePath: ex.assetImagePath,
              sets: validSets,
              reps: ex.reps.take(validSets).toList(),
              weight: ex.weight.take(validSets).toList(),
            );
          }

          return null;
        })
        .whereType<ExerciseTrainingModel>()
        .toList();
  }

  static Future<ExerciseModel?> showExercisePickerDialog({
    required BuildContext context,
    required List<ExerciseModel> availableExercises,
  }) {
    availableExercises.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    return showDialog<ExerciseModel>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(AppStrings.addExercise),
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: availableExercises.map((exercise) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () => Navigator.pop(context, exercise),
                        title: Text(exercise.name),
                        subtitle: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: exercise.bodyParts
                              .map((part) => BodyPartChip(part: part))
                              .toList(),
                        ),
                        leading: exercise.assetImagePath.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  exercise.assetImagePath,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.fitness_center,
                                size: 32,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                      ),
                      const Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showThemeBottomSheet(BuildContext context) async {
    final notifier = context.read<SettingsNotifier>();
    final selected = notifier.settings.themeModeIndex;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(AppStrings.chooseTheme,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: List.generate(3, (i) {
                final isSelected = selected == i;
                final label =
                    [AppStrings.system, AppStrings.light, AppStrings.dark][i];
                final icon =
                    [Icons.smartphone, Icons.light_mode, Icons.dark_mode][i];

                return ChoiceChip(
                  label: Text(label),
                  avatar: Icon(icon, size: 20),
                  checkmarkColor: Colors.white,
                  selected: isSelected,
                  onSelected: (_) {
                    Navigator.pop(context);
                    notifier.updateThemeMode(i);
                  },
                );
              }),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
