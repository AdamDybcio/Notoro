import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/views/workout/widgets/exercise_tile.dart';

class AvailableExercises extends StatelessWidget {
  const AvailableExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
        builder: (context, state) {
          state.availableExercises.sort(
            (a, b) => a.name.compareTo(b.name),
          );
          var availableExercises = state.availableExercises.toList();
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: availableExercises.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final exercise = availableExercises[index];

              return LongPressDraggable<ExerciseModel>(
                data: exercise,
                feedback: Material(
                  color: Colors.transparent,
                  child: Opacity(
                    opacity: 0.9,
                    child: SizedBox(
                      width: 220,
                      child: ExerciseTile(
                        exercise: exercise,
                        showDeleteIcon: false,
                      ),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 220,
                  child: ExerciseTile(
                    exercise: exercise,
                    onDelete: exercise.isCustom
                        ? () async {
                            final shouldDelete =
                                await Helpers.showDeleteConfirmationDialog(
                                    context: context,
                                    title: AppStrings.removeExercise,
                                    content:
                                        AppStrings.removeExerciseConfirmation,
                                    confirmText: AppStrings.remove,
                                    isNegative: true);
                            if (shouldDelete == true) {
                              //onRemove();
                            }
                          }
                        : null,
                    showDeleteIcon: exercise.isCustom,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
