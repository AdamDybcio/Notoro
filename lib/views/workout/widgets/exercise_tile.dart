import 'package:flutter/material.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/exercise_model.dart';

class ExerciseTile extends StatelessWidget {
  final ExerciseModel exercise;
  const ExerciseTile({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            exercise.icon ?? Icons.fitness_center,
            size: 32,
            color: colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: -6,
                  children: exercise.bodyParts
                      .map((part) => Icon(
                            Helpers.mapBodyPartToIcon(part),
                            size: 14,
                            color: Colors.grey,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
