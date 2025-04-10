import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/views/workout/widgets/selected_exercise_tile.dart';

class SelectedExercises extends StatelessWidget {
  const SelectedExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
      builder: (context, state) {
        return DragTarget<ExerciseModel>(
          onAcceptWithDetails: (exercise) {
            context
                .read<WorkoutBuilderBloc>()
                .add(AddExerciseToWorkout(exercise.data));
          },
          builder: (context, candidateData, rejectedData) {
            final bool isHovering = candidateData.isNotEmpty;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 250,
              decoration: BoxDecoration(
                color: isHovering
                    ? Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withAlpha(50)
                    : Colors.transparent,
                border: Border.all(
                  color: isHovering
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withAlpha(50)
                          : Colors.white.withAlpha(50),
                  width: isHovering ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: state.selectedExercises.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.dragExerciseHere,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.selectedExercises.length,
                      itemBuilder: (context, index) {
                        return SelectedExerciseTile(
                          exercise: state.selectedExercises[index],
                          onRemove: () {
                            context.read<WorkoutBuilderBloc>().add(
                                  RemoveExerciseFromWorkout(
                                    index,
                                  ),
                                );
                          },
                        );
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
