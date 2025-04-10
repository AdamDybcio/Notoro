import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/views/workout/widgets/exercise_tile.dart';

class AvailableExercises extends StatelessWidget {
  const AvailableExercises({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
        builder: (context, state) {
          return ListView.separated(
            itemCount: state.availableExercises.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final exercise = state.availableExercises[index];
              return LongPressDraggable<ExerciseModel>(
                data: exercise,
                feedback: Material(
                  color: Colors.transparent,
                  child: Opacity(
                    opacity: 0.8,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: ExerciseTile(exercise: exercise),
                    ),
                  ),
                ),
                child: ExerciseTile(
                  exercise: exercise,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
