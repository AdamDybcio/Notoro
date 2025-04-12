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
    on<LoadAvailableExercises>(onLoadAvailableExercises);
    on<AddExerciseToWorkout>(onAddExercise);
    on<RemoveExerciseFromWorkout>(onRemoveExercise);
    on<UpdateExerciseSet>(onUpdateExerciseSet);
    on<ReorderExercise>(onReorderExercise);
  }

  void onLoadAvailableExercises(
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

  void onAddExercise(
    AddExerciseToWorkout event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final newList = List<ExerciseTrainingModel>.from(state.selectedExercises)
      ..add(ExerciseTrainingModel(
        event.exercise.icon,
        name: event.exercise.name,
        bodyParts: event.exercise.bodyParts,
        sets: 4,
        reps: [8, 8, 8, 8],
        weight: [0, 0, 0, 0],
      ));

    emit(state.copyWith(selectedExercises: newList));
  }

  void onRemoveExercise(
    RemoveExerciseFromWorkout event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final newList = List<ExerciseTrainingModel>.from(state.selectedExercises)
      ..removeAt(event.index);

    emit(state.copyWith(selectedExercises: newList));
  }

  void onUpdateExerciseSet(
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

  void onReorderExercise(
    ReorderExercise event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final list = List<ExerciseTrainingModel>.from(state.selectedExercises);

    if (event.oldIndex < 0 || event.oldIndex >= list.length) return;
    if (event.newIndex < 0 || event.newIndex >= list.length) return;
    final item = list.removeAt(event.oldIndex);
    list.insert(event.newIndex, item);

    emit(state.copyWith(selectedExercises: list));
  }
}
