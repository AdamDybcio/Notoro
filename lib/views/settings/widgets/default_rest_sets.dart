import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/views/settings/widgets/number_picker_dialog.dart';
import 'package:provider/provider.dart';

class DefaultRestBetweenSetsTile extends StatelessWidget {
  const DefaultRestBetweenSetsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SettingsNotifier>();
    final value = notifier.settings.defaultRestBetweenSets;

    return ListTile(
      title: const Text(AppStrings.defaultRestBetweenSets),
      subtitle: Text('$value ${AppStrings.sec}'),
      leading: const Icon(Icons.timer_outlined),
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
          notifier.updateDefaultRestBetweenSets(result);
        }
      },
    );
  }
}
