import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_bloc.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_event.dart';
import 'package:notoro/controllers/workout_builder/workout_builder_state.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/helpers/custom_snackbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:notoro/views/workout/widgets/selected_excercises.dart';

import 'widgets/available_exercises.dart';

class NewWorkoutView extends StatelessWidget {
  const NewWorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkoutBuilderBloc>(
      create: (_) => WorkoutBuilderBloc()..add(LoadAvailableExercises()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonAppbar(
          title: AppStrings.newWorkout,
          actions: [
            BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async {
                    final name =
                        context.read<WorkoutBuilderBloc>().state.workoutName;
                    final box = Hive.box<WorkoutModel>('workouts');
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackbar.show(
                          context: context,
                          message: AppStrings.workoutNameEmpty,
                        ),
                      );
                      return;
                    }
                    final bloc = context.read<WorkoutBuilderBloc>();
                    final exercises = bloc.state.selectedExercises;
                    if (exercises.isEmpty) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackbar.show(
                          context: context,
                          message: AppStrings.addOneExercise,
                        ),
                      );
                      return;
                    }
                    final newWorkout = WorkoutModel(
                      name: name,
                      exercises: exercises,
                    );
                    await box.add(newWorkout);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackbar.show(
                        // ignore: use_build_context_synchronously
                        context: context,
                        message: AppStrings.workoutCreated,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check, size: 30),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              BlocBuilder<WorkoutBuilderBloc, WorkoutBuilderState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (value) =>
                        BlocProvider.of<WorkoutBuilderBloc>(context)
                            .add(UpdateWorkoutName(value)),
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      labelText: AppStrings.workoutName,
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              HeaderDivider(text: AppStrings.excercises),
              const SizedBox(height: 20),
              Expanded(child: SelectedExercises()),
              const SizedBox(height: 20),
              HeaderDivider(text: AppStrings.availableExercises),
              const SizedBox(height: 20),
              AvailableExercises(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
