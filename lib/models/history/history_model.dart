import 'package:hive_flutter/hive_flutter.dart';

import '../workout/exercise_training_model.dart';

part 'history_model.g.dart';

@HiveType(typeId: 7)
class HistoryModel extends HiveObject {
  @HiveField(0)
  final String workoutName;

  @HiveField(1)
  final List<ExerciseTrainingModel> exercises;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final Duration duration;

  HistoryModel({
    required this.workoutName,
    required this.exercises,
    required this.date,
    required this.duration,
  });
}
