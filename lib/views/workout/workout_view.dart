import 'package:flutter/material.dart';
import 'package:notoro/core/common/widgets/header_divider.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/views/workout/widgets/new_workout_button.dart';

import '../../core/common/widgets/empty_state_widget.dart';
import 'new_workout_view.dart';

class WorkoutView extends StatelessWidget {
  const WorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.fitness_center_outlined,
        title: AppStrings.workout,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          children: [
            NewWorkoutButton(onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewWorkoutView(),
                  ));
            }),
            const SizedBox(height: 20),
            HeaderDivider(text: AppStrings.yourWorkouts),
            const SizedBox(height: 20),
            EmptyStateWidget(
              title: AppStrings.noWorkoutsTitle,
              subtitle: AppStrings.noWorkoutsSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
