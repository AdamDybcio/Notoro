import 'package:flutter/material.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

class SelectedExerciseTile extends StatelessWidget {
  final ExerciseTrainingModel exercise;
  final VoidCallback onRemove;
  final VoidCallback onEdit;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final bool isFirst;
  final bool isLast;

  const SelectedExerciseTile({
    super.key,
    required this.exercise,
    required this.onRemove,
    required this.onEdit,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.isFirst,
    required this.isLast,
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
                Icon(
                  exercise.icon ?? Icons.fitness_center,
                  size: 28,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    exercise.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 20),
                  tooltip: AppStrings.editSets,
                ),
                IconButton(
                  onPressed: onRemove,
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
                    runSpacing: -8,
                    children: List.generate(
                      exercise.sets,
                      (index) => Chip(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        label: Text(
                          '${exercise.reps[index]}x${exercise.weight[index]}kg',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
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
