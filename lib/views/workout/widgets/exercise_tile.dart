import 'package:flutter/material.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/models/workout/exercise_model.dart';

class ExerciseTile extends StatelessWidget {
  final ExerciseModel exercise;
  const ExerciseTile({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          exercise.icon ?? Icons.fitness_center,
          size: 48,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        title: Text(
          exercise.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        subtitle: Wrap(
          spacing: 4,
          children: exercise.bodyParts
              .map((part) => Icon(
                    Helpers.mapBodyPartToIcon(part),
                    size: 16,
                    color: Colors.grey,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
