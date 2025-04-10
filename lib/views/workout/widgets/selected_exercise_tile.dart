import 'package:flutter/material.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

class SelectedExerciseTile extends StatelessWidget {
  final ExerciseTrainingModel exercise;
  final VoidCallback onRemove;

  const SelectedExerciseTile({
    super.key,
    required this.exercise,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  exercise.icon ?? Icons.fitness_center,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    exercise.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onRemove,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(
                exercise.sets,
                (index) => Chip(
                  label: Text(
                      '${exercise.reps[index]}x${exercise.weight[index]}kg'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('Edytuj serie'),
            ),
          ],
        ),
      ),
    );
  }
}
