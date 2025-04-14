import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notoro/controllers/active_workout/workout_session_controller.dart';
import 'package:notoro/core/common/widgets/common_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:provider/provider.dart';

class WorkoutSessionBody extends StatelessWidget {
  const WorkoutSessionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutSessionController>(
      builder: (context, controller, _) {
        final theme = Theme.of(context);

        if (controller.isFinished) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.celebration, size: 64, color: Colors.green),
                const SizedBox(height: 20),
                Text(
                  'Trening zakończony!',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () {
                    final history = HistoryModel(
                      workoutName: controller.workout.name,
                      exercises: controller.updatedExercises,
                      date: DateTime.now(),
                      duration: controller.elapsed,
                    );
                    Hive.box<HistoryModel>('workout_history').add(history);
                    controller.disposeController();

                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Zapisz i wróć'),
                )
              ],
            ),
          );
        }

        final exercise = controller.currentExerciseModel;
        final setIndex = controller.currentSet;
        final isRest = controller.isResting;

        return Scaffold(
          appBar: CommonAppbar(
            title: AppStrings.workout,
            actions: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    _formatDuration(controller.elapsed),
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isRest) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Przerwa',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _formatDuration(controller.restRemaining),
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: controller.add15sRest,
                    icon: const Icon(Icons.add),
                    label: const Text('+15 sekund'),
                  ),
                ] else ...[
                  Text(
                    exercise.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Seria ${setIndex + 1} / ${exercise.sets}',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${exercise.reps[setIndex]} powt. • ${exercise.weight[setIndex]} kg',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      _showEditSetDialog(context, controller, setIndex);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Zmień wartość'),
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: controller.finishSet,
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Zakończ serię'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _showEditSetDialog(
    BuildContext context,
    WorkoutSessionController controller,
    int setIndex,
  ) {
    final ex = controller.currentExerciseModel;
    final repsController =
        TextEditingController(text: ex.reps[setIndex].toString());
    final weightController =
        TextEditingController(text: ex.weight[setIndex].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edytuj serię'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Powtórzenia'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Ciężar (kg)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Anuluj'),
          ),
          ElevatedButton(
            onPressed: () {
              final reps =
                  int.tryParse(repsController.text) ?? ex.reps[setIndex];
              final weight =
                  double.tryParse(weightController.text) ?? ex.weight[setIndex];

              controller.editSet(setIndex, reps, weight);
              Navigator.pop(context);
            },
            child: const Text('Zapisz'),
          )
        ],
      ),
    );
  }
}
