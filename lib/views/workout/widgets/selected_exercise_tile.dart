import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/enums/app_enums.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

import 'body_part_chip.dart';

class SelectedExerciseTile extends StatelessWidget {
  final ExerciseTrainingModel exercise;
  final VoidCallback onRemove;
  final VoidCallback onEdit;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final bool isFirst;
  final bool isLast;
  final int exerciseIndex;

  const SelectedExerciseTile({
    super.key,
    required this.exercise,
    required this.onRemove,
    required this.onEdit,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.isFirst,
    required this.isLast,
    required this.exerciseIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    Helpers.mapBodyPartToString(BodyPart.chest),
                    width: 56,
                    height: 56,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        exercise.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: exercise.bodyParts
                              .map((part) => BodyPartChip(part: part))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final shouldDelete =
                        await Helpers.showDeleteConfirmationDialog(
                            context: context,
                            title: AppStrings.removeExercise,
                            content: AppStrings.removeExerciseConfirmation,
                            confirmText: AppStrings.remove,
                            isNegative: true);
                    if (shouldDelete == true) {
                      onRemove();
                    }
                  },
                  icon: const Icon(Icons.delete_outline, size: 20),
                  tooltip: AppStrings.deleteExercise,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: -2,
                    children: [
                      ...List.generate(
                        exercise.sets,
                        (index) {
                          return ActionChip(
                            onPressed: () {
                              Helpers.showEditSetDialog(
                                context: context,
                                index: index,
                                exercise: exercise,
                                exerciseIndex: exerciseIndex,
                              );
                            },
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            label: Text(
                              '${exercise.reps[index]}x${exercise.weight[index]}kg',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                      ActionChip(
                        label: Text(
                          AppStrings.add,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          final updatedReps = List<int>.from(exercise.reps)
                            ..add(8);
                          final updatedWeight =
                              List<double>.from(exercise.weight)..add(0);
                          context.read<WorkoutBuilderBloc>().add(
                                UpdateFullExercise(
                                  exerciseIndex: exerciseIndex,
                                  newSets: updatedReps.length,
                                  newReps: updatedReps,
                                  newWeight: updatedWeight,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, size: 20),
                      tooltip: AppStrings.moveUp,
                      onPressed: isFirst ? null : onMoveUp,
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward, size: 20),
                      tooltip: AppStrings.moveDown,
                      onPressed: isLast ? null : onMoveDown,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
