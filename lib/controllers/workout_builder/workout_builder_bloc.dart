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
    on<UpdateFullExercise>(onUpdateFullExercise);
  }

  void onLoadAvailableExercises(
    LoadAvailableExercises event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    emit(state.copyWith(
      availableExercises: [
        ExerciseModel(Icons.fitness_center,
            name: 'Ławka płaska',
            bodyParts: [BodyPart.chest, BodyPart.shoulders]),
        ExerciseModel(Icons.sports_gymnastics,
            name: 'Przysiad', bodyParts: [BodyPart.legs]),
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
    final list = List<ExerciseTrainingModel>.from(state.selectedExercises);
    final current = list[event.exerciseIndex];

    if (event.setIndex < 0 || event.setIndex >= current.sets) return;

    final updatedReps = List<int>.from(current.reps);
    final updatedWeight = List<double>.from(current.weight);

    updatedReps[event.setIndex] = event.newReps;
    updatedWeight[event.setIndex] = event.newWeight;

    final updatedExercise = ExerciseTrainingModel(
      current.icon,
      name: current.name,
      bodyParts: current.bodyParts,
      sets: current.sets,
      reps: updatedReps,
      weight: updatedWeight,
    );

    list[event.exerciseIndex] = updatedExercise;

    emit(state.copyWith(selectedExercises: list));
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

  void onUpdateFullExercise(
    UpdateFullExercise event,
    Emitter<WorkoutBuilderState> emit,
  ) {
    final list = List<ExerciseTrainingModel>.from(state.selectedExercises);

    if (event.exerciseIndex < 0 || event.exerciseIndex >= list.length) return;

    final current = list[event.exerciseIndex];

    final updatedExercise = ExerciseTrainingModel(
      current.icon,
      name: current.name,
      bodyParts: current.bodyParts,
      sets: event.newSets,
      reps: event.newReps,
      weight: event.newWeight,
    );

    list[event.exerciseIndex] = updatedExercise;

    emit(state.copyWith(selectedExercises: list));
  }
}
