import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import '../../models/workout/workout_model.dart';
import 'workout_detail_event.dart';
import 'workout_detail_state.dart';

class WorkoutDetailBloc extends Bloc<WorkoutDetailEvent, WorkoutDetailState> {
  final Box<WorkoutModel> workoutBox;

  WorkoutDetailBloc(this.workoutBox)
      : super(const WorkoutDetailState(workout: null)) {
    on<LoadWorkoutDetail>(onLoadWorkout);
    on<RemoveExerciseFromDetailWorkout>(onRemoveExercise);
    on<ReorderExerciseInDetail>(onReorder);
    on<AddSetToExerciseFromDetail>(onAddSet);
    on<UpdateExerciseSetFromDetail>(onUpdateSet);
    on<RemoveSetFromExerciseFromDetail>(onRemoveSet);
  }

  void onLoadWorkout(
      LoadWorkoutDetail event, Emitter<WorkoutDetailState> emit) {
    final workout = workoutBox.get(event.workoutKey);
    emit(state.copyWith(workout: workout));
  }

  void onRemoveExercise(
      RemoveExerciseFromDetailWorkout event, Emitter<WorkoutDetailState> emit) {
    final updated = List<ExerciseTrainingModel>.from(state.workout!.exercises)
      ..removeAt(event.index);

    final newWorkout = state.workout!.copyWith(exercises: updated);
    workoutBox.putAt(event.index, newWorkout);
    emit(state.copyWith(workout: newWorkout));
  }

  void onReorder(
      ReorderExerciseInDetail event, Emitter<WorkoutDetailState> emit) {
    final list = List<ExerciseTrainingModel>.from(state.workout!.exercises);
    final item = list.removeAt(event.oldIndex);
    list.insert(event.newIndex, item);

    final newWorkout = state.workout!.copyWith(exercises: list);
    workoutBox.put(state.workout!.key, newWorkout);
    emit(state.copyWith(workout: newWorkout));
  }

  void onAddSet(
      AddSetToExerciseFromDetail event, Emitter<WorkoutDetailState> emit) {
    final exercises =
        List<ExerciseTrainingModel>.from(state.workout!.exercises);
    final ex = exercises[event.exerciseIndex];

    final updated = ex.copyWith(
      sets: ex.sets + 1,
      reps: [...ex.reps, 8],
      weight: [...ex.weight, 0],
    );

    exercises[event.exerciseIndex] = updated;
    final newWorkout = state.workout!.copyWith(exercises: exercises);
    workoutBox.put(state.workout!.key, newWorkout);
    emit(state.copyWith(workout: newWorkout));
  }

  void onUpdateSet(
      UpdateExerciseSetFromDetail event, Emitter<WorkoutDetailState> emit) {
    final exercises =
        List<ExerciseTrainingModel>.from(state.workout!.exercises);
    final ex = exercises[event.exerciseIndex];

    final newReps = [...ex.reps]..[event.setIndex] = event.reps;
    final newWeight = [...ex.weight]..[event.setIndex] = event.weight;

    final updated = ex.copyWith(
      reps: newReps,
      weight: newWeight,
    );

    exercises[event.exerciseIndex] = updated;
    final newWorkout = state.workout!.copyWith(exercises: exercises);
    workoutBox.put(state.workout!.key, newWorkout);
    emit(state.copyWith(workout: newWorkout));
  }

  void onRemoveSet(
    RemoveSetFromExerciseFromDetail event,
    Emitter<WorkoutDetailState> emit,
  ) {
    final exercises =
        List<ExerciseTrainingModel>.from(state.workout!.exercises);
    final ex = exercises[event.exerciseIndex];

    final newReps = [...ex.reps]..removeAt(event.setIndex);
    final newWeight = [...ex.weight]..removeAt(event.setIndex);
    final updated = ex.copyWith(
      sets: ex.sets - 1,
      reps: newReps,
      weight: newWeight,
    );

    exercises[event.exerciseIndex] = updated;
    final newWorkout = state.workout!.copyWith(exercises: exercises);

    workoutBox.put(state.workout!.key, newWorkout);
    emit(state.copyWith(workout: newWorkout));
  }
}
