import 'package:equatable/equatable.dart';

import '../../models/workout/workout_model.dart';

class WorkoutDetailState extends Equatable {
  final WorkoutModel? workout;

  const WorkoutDetailState({required this.workout});

  WorkoutDetailState copyWith({WorkoutModel? workout}) {
    return WorkoutDetailState(workout: workout ?? this.workout);
  }

  @override
  List<Object?> get props => [workout];
}
