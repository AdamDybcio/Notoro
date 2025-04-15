import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:provider/provider.dart';

class ResetToDefaultsTile extends StatelessWidget {
  const ResetToDefaultsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<SettingsNotifier>();

    return ListTile(
      title: const Text(AppStrings.resetDefaultsTile),
      leading: const Icon(Icons.restore_outlined),
      onTap: () async {
        final confirm = await Helpers.showDeleteConfirmationDialog(
          context: context,
          title: AppStrings.resetDefaults,
          content: AppStrings.resetDefaultsSubtitle,
          confirmText: AppStrings.yes,
          isNegative: false,
        );
        if (confirm == true) {
          notifier.resetToDefaults();
        }
      },
    );
  }
}
