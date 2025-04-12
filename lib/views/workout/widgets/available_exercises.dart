import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
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
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.availableExercises.length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final exercise = state.availableExercises[index];

              return LongPressDraggable<ExerciseModel>(
                data: exercise,
                feedback: Material(
                  color: Colors.transparent,
                  child: Opacity(
                    opacity: 0.9,
                    child: SizedBox(
                      width: 220,
                      child: ExerciseTile(exercise: exercise),
                    ),
                  ),
                ),
                child: SizedBox(
                  width: 220,
                  child: ExerciseTile(exercise: exercise),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
