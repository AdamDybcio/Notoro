import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_bloc.dart';
import 'package:notoro/controllers/weekly_plan/weekly_plan_state.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/views/home/workout_configuration_view.dart';

class TodayWorkoutBanner extends StatelessWidget {
  const TodayWorkoutBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeeklyPlanBloc, WeeklyPlanState>(
      builder: (context, state) {
        final plan = state.plan;
        if (plan == null) return const SizedBox.shrink();

        final today = Helpers.getTodayEnum();
        final workoutKey = plan.workoutKeys[today];

        if (workoutKey == null) return const SizedBox.shrink();
        final workout = state.availableWorkouts[workoutKey];
        if (workout == null) return const SizedBox.shrink();

        return Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: RichText(
              text: TextSpan(
                text: AppStrings.todayWorkout,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                children: [
                  TextSpan(
                    text: workout.name,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            trailing: FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WorkoutConfigurationView(workout: workout),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text(AppStrings.startWorkout),
            ),
          ),
        );
      },
    );
  }
}
