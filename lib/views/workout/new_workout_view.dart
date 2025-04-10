import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/views/workout/widgets/selected_excercises.dart';

import 'widgets/available_exercises.dart';

class NewWorkoutView extends StatelessWidget {
  const NewWorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: AppStrings.newWorkout),
      body: BlocProvider(
        create: (_) => WorkoutBuilderBloc()..add(LoadAvailableExercises()),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  labelText: AppStrings.workoutName,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              HeaderDivider(text: AppStrings.excercises),
              const SizedBox(height: 20),
              SelectedExercises(),
              const SizedBox(height: 20),
              HeaderDivider(text: 'Dostępne ćwiczenia'),
              const SizedBox(height: 20),
              AvailableExercises(),
            ],
          ),
        ),
      ),
    );
  }
}
