import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/core/utils/enums/app_enums.dart';
import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

class WorkoutBuilderBloc
    extends Bloc<WorkoutBuilderEvent, WorkoutBuilderState> {
  WorkoutBuilderBloc()
      : super(WorkoutBuilderState(
          availableExercises: [],
          selectedExercises: [],
        )) {
    on<LoadAvailableExercises>(_onLoadAvailableExercises);
    on<AddExerciseToWorkout>(_onAddExercise);
    on<RemoveExerciseFromWorkout>(_onRemoveExercise);
    on<UpdateExerciseSet>(_onUpdateExerciseSet);
  }

  void _onLoadAvailableExercises(
    LoadAvailableExercises event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    emit(state.copyWith(
      availableExercises: [
        ExerciseModel(Icons.fitness_center,
            name: 'Bench Press', bodyParts: [BodyPart.chest]),
        ExerciseModel(Icons.sports_gymnastics,
            name: 'Squat', bodyParts: [BodyPart.legs]),
      ],
    ));
  }

  void _onAddExercise(
    AddExerciseToWorkout event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final newList = List<ExerciseTrainingModel>.from(state.selectedExercises)
      ..add(ExerciseTrainingModel(
        event.exercise.icon,
        name: event.exercise.name,
        bodyParts: event.exercise.bodyParts,
        sets: 3,
        reps: [10, 10, 10],
        weight: [0, 0, 0],
      ));

    emit(state.copyWith(selectedExercises: newList));
  }

  void _onRemoveExercise(
    RemoveExerciseFromWorkout event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final newList = List<ExerciseTrainingModel>.from(state.selectedExercises)
      ..removeAt(event.index);

    emit(state.copyWith(selectedExercises: newList));
  }

  void _onUpdateExerciseSet(
    UpdateExerciseSet event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final updatedList =
        List<ExerciseTrainingModel>.from(state.selectedExercises);
    final exercise = updatedList[event.index];

    updatedList[event.index] = ExerciseTrainingModel(
      exercise.icon,
      name: exercise.name,
      bodyParts: exercise.bodyParts,
      sets: event.sets,
      reps: event.reps,
      weight: event.weight,
    );

    emit(state.copyWith(selectedExercises: updatedList));
  }
}
