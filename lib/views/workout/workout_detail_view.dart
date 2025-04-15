// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_bloc.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_event.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_state.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/helpers/custom_snackbar.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:notoro/views/workout/widgets/workout_exercise_tile.dart';

import 'widgets/workout_stats_section.dart';

class WorkoutDetailView extends StatelessWidget {
  const WorkoutDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(
        title: AppStrings.workoutDetails,
        actions: [
          BlocBuilder<WorkoutDetailBloc, WorkoutDetailState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  final shouldDelete =
                      await Helpers.showDeleteConfirmationDialog(
                    context: context,
                    title: AppStrings.removeWorkout,
                    content: AppStrings.removeWorkoutConfirmation,
                    confirmText: AppStrings.remove,
                    isNegative: true,
                  );
                  if (shouldDelete == true) {
                    final box = Hive.box<WorkoutModel>('workouts');
                    await box.delete(box.values
                        .firstWhere(
                            (element) => element.name == state.workout!.name)
                        .key);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackbar.show(
                        context: context,
                        message: AppStrings.workoutDeleted,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.delete_outline, size: 30),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<WorkoutDetailBloc, WorkoutDetailState>(
        builder: (context, state) {
          final workout = state.workout;

          if (workout == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final exercises = workout.exercises;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WorkoutStatsSection(workout: workout),
                  const SizedBox(height: 20),
                  HeaderDivider(
                    text: "${AppStrings.excercises} (${exercises.length})",
                    actionButton: IconButton(
                      onPressed: () async {
                        final exercise = await Helpers.showExercisePickerDialog(
                          context: context,
                          availableExercises: state.availableExercises,
                        );
                        if (exercise != null) {
                          final trainingExercise = ExerciseTrainingModel(
                            name: exercise.name,
                            bodyParts: exercise.bodyParts,
                            assetImagePath: exercise.assetImagePath,
                            sets: 4,
                            reps: List.filled(4, 8),
                            weight: List.filled(4, 0),
                          );
                          context.read<WorkoutDetailBloc>().add(
                                AddExerciseToWorkoutDetails(trainingExercise),
                              );
                        }
                      },
                      icon: Icon(Icons.add,
                          size: 30,
                          color: Theme.of(context).colorScheme.onPrimary),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (int i = 0; i < exercises.length; i++) ...{
                    WorkoutExerciseTile(
                      exercise: exercises[i],
                      onRemove: () {
                        context.read<WorkoutDetailBloc>().add(
                              RemoveExerciseFromDetailWorkout(i),
                            );
                      },
                      onMoveUp: () {
                        context.read<WorkoutDetailBloc>().add(
                              ReorderExerciseInDetail(i, i - 1),
                            );
                      },
                      onMoveDown: () {
                        context.read<WorkoutDetailBloc>().add(
                              ReorderExerciseInDetail(i, i + 1),
                            );
                      },
                      isFirst: i == 0,
                      isLast: i == exercises.length - 1,
                      exerciseIndex: i,
                      onAddSet: () {
                        context.read<WorkoutDetailBloc>().add(
                              AddSetToExerciseFromDetail(i),
                            );
                      },
                      onEditSetDialogWorkout: true,
                    ),
                    const SizedBox(height: 12),
                  },
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
