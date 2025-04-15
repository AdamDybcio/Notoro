import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:provider/provider.dart';

import 'number_picker_dialog.dart';

class DefaultRestBetweenExercisesTile extends StatelessWidget {
  const DefaultRestBetweenExercisesTile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SettingsNotifier>();
    final value = notifier.settings.defaultRestBetweenExercises;

    return ListTile(
      title: const Text(AppStrings.defaultRestBetweenExercises),
      subtitle: Text('$value ${AppStrings.sec}'),
      leading: const Icon(Icons.access_time_outlined),
      onTap: () async {
        final result = await showDialog<int>(
          context: context,
          builder: (_) => NumberPickerDialog(
            title: AppStrings.chooseRest,
            initialValue: value,
            minValue: 15,
            maxValue: 180,
            step: 15,
          ),
        );
        if (result != null) {
          notifier.updateDefaultRestBetweenExercises(result);
        }
      },
    );
  }
}
