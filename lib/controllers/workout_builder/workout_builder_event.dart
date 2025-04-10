import 'package:notoro/models/workout/exercise_model.dart';

abstract class WorkoutBuilderEvent {}

class LoadAvailableExercises extends WorkoutBuilderEvent {}

class AddExerciseToWorkout extends WorkoutBuilderEvent {
  final ExerciseModel exercise;
  AddExerciseToWorkout(this.exercise);
}

class RemoveExerciseFromWorkout extends WorkoutBuilderEvent {
  final int index;
  RemoveExerciseFromWorkout(this.index);
}

class UpdateExerciseSet extends WorkoutBuilderEvent {
  final int index;
  final int sets;
  final List<int> reps;
  final List<double> weight;

  UpdateExerciseSet({
    required this.index,
    required this.sets,
    required this.reps,
    required this.weight,
  });
}
