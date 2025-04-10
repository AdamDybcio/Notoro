import 'package:notoro/models/workout/exercise_model.dart';

class ExerciseTrainingModel extends ExerciseModel {
  final int sets;
  final List<int> reps;
  final List<double> weight;

  ExerciseTrainingModel(
    super.icon, {
    required this.sets,
    required this.reps,
    required this.weight,
    required super.name,
    required super.bodyParts,
  });
}
