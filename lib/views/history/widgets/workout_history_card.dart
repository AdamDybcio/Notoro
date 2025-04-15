import 'package:flutter/material.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/views/home/workout_summary_view.dart';

class WorkoutHistoryCard extends StatelessWidget {
  final HistoryModel history;

  const WorkoutHistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    final totalVolume = history.exercises.fold<double>(0.0, (sum, ex) {
      for (int i = 0; i < ex.sets; i++) {
        sum += ex.reps[i] * ex.weight[i];
      }
      return sum;
    });

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.fitness_center,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 32,
          ),
        ),
        title: Text(
          history.workoutName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          '${history.exercises.length} ${AppStrings.exercisesLowercase} • ${Helpers.formatDuration(history.duration)} • ${totalVolume.toStringAsFixed(0)} ${AppStrings.kg}',
        ),
        trailing: history.wasAbandoned
            ? const Icon(Icons.warning_amber, color: Colors.red)
            : const Icon(Icons.check_circle, color: Colors.green),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WorkoutSummaryView(history: history),
            ),
          );
        },
      ),
    );
  }
}
