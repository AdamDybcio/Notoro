import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notoro/core/common/widgets/empty_state_widget.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/models/history/history_model.dart';
import 'package:notoro/views/history/widgets/workout_history_card.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyBox = Hive.box<HistoryModel>('workout_history');

    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.history_outlined,
        title: AppStrings.history,
      ),
      body: ValueListenableBuilder(
        valueListenable: historyBox.listenable(),
        builder: (context, Box<HistoryModel> box, _) {
          final items = box.values.toList()
            ..sort((a, b) => b.date.compareTo(a.date));

          if (items.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: EmptyStateWidget(
                title: AppStrings.noHistoryTitle,
                subtitle: AppStrings.noHistorySubtitle,
              ),
            );
          }

          final grouped = <String, List<HistoryModel>>{};
          for (final item in items) {
            final date = DateFormat.yMMMMd(AppStrings.locale).format(item.date);
            grouped.putIfAbsent(date, () => []).add(item);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
              final date = grouped.keys.elementAt(index);
              final workouts = grouped[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  ...workouts
                      .map((workout) => WorkoutHistoryCard(history: workout)),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
