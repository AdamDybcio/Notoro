import 'package:flutter/material.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_model.dart';

import 'body_part_chip.dart';

class ExerciseTile extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback? onDelete;
  final bool? showDeleteIcon;
  const ExerciseTile(
      {super.key,
      required this.exercise,
      this.onDelete,
      this.showDeleteIcon = true});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onDelete != null && showDeleteIcon == true)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/body_parts/chest.png',
                    height: 36,
                    width: 36,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 20,
                    ),
                    tooltip: AppStrings.deleteExercise,
                  ),
                ),
              ],
            )
          else
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/body_parts/chest.png',
                  height: 36,
                  width: 36,
                ),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimaryContainer,
                      ),
                ),
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
        ],
      ),
    );
  }
}
