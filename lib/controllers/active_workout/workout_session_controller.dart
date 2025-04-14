import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notoro/models/workout/exercise_training_model.dart';
import 'package:notoro/models/workout/workout_model.dart';

class WorkoutSessionController extends ChangeNotifier {
  final WorkoutModel workout;
  final Map<int, int> restBetweenSets;
  final Map<int, int> restAfterExercises;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _restTimer;
  Timer? _tickTimer;

  int currentExercise = 0;
  int currentSet = 0;
  Duration restRemaining = Duration.zero;
  bool isResting = false;

  late List<ExerciseTrainingModel> updatedExercises;

  WorkoutSessionController({
    required this.workout,
    required this.restBetweenSets,
    required this.restAfterExercises,
  }) {
    updatedExercises = workout.exercises
        .map((e) => ExerciseTrainingModel(
              name: e.name,
              bodyParts: e.bodyParts,
              assetImagePath: e.assetImagePath,
              sets: e.sets,
              reps: List.from(e.reps),
              weight: List.from(e.weight),
            ))
        .toList();

    _stopwatch.start();
    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });

    notifyListeners();
  }

  Duration get elapsed => _stopwatch.elapsed;

  ExerciseTrainingModel get currentExerciseModel =>
      updatedExercises[currentExercise];

  void finishSet() {
    if (currentSet < currentExerciseModel.sets - 1) {
      currentSet++;
      _startRest(restBetweenSets[currentExercise] ?? 60);
    } else if (currentExercise < updatedExercises.length - 1) {
      currentExercise++;
      currentSet = 0;
      _startRest(restAfterExercises[currentExercise - 1] ?? 90);
    } else {
      _stopwatch.stop();
      notifyListeners();
    }
  }

  void _startRest(int seconds) {
    restRemaining = Duration(seconds: seconds);
    isResting = true;
    notifyListeners();

    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      restRemaining -= const Duration(seconds: 1);
      if (restRemaining.inSeconds <= 0) {
        timer.cancel();
        isResting = false;
      }
      notifyListeners();
    });
  }

  void add15sRest() {
    restRemaining += const Duration(seconds: 15);
    notifyListeners();
  }

  void editSet(int setIndex, int newReps, double newWeight) {
    currentExerciseModel.reps[setIndex] = newReps;
    currentExerciseModel.weight[setIndex] = newWeight;
    notifyListeners();
  }

  bool get isFinished =>
      currentExercise == updatedExercises.length - 1 &&
      currentSet == currentExerciseModel.sets - 1 &&
      !isResting;

  void disposeController() {
    _restTimer?.cancel();
    _tickTimer?.cancel();
    _stopwatch.stop();
  }
}
