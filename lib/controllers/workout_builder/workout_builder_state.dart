import 'package:notoro/models/workout/exercise_model.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';

class WorkoutBuilderState {
  final List<ExerciseModel> availableExercises;
  final List<ExerciseTrainingModel> selectedExercises;

  WorkoutBuilderState({
    required this.availableExercises,
    required this.selectedExercises,
  });

  WorkoutBuilderState copyWith({
    List<ExerciseModel>? availableExercises,
    List<ExerciseTrainingModel>? selectedExercises,
  }) {
    return WorkoutBuilderState(
      availableExercises: availableExercises ?? this.availableExercises,
      selectedExercises: selectedExercises ?? this.selectedExercises,
    );
  }
}
