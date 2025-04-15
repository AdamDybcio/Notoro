import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/helpers/helpers.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:provider/provider.dart';

class ThemeSettingTile extends StatelessWidget {
  const ThemeSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SettingsNotifier>();
    final index = notifier.settings.themeModeIndex;

    return ListTile(
      title: const Text(AppStrings.theme),
      subtitle: Text(
        switch (index) {
          1 => AppStrings.light,
          2 => AppStrings.dark,
          _ => AppStrings.system,
        },
      ),
      leading: const Icon(Icons.color_lens_outlined),
      onTap: () => Helpers.showThemeBottomSheet(context),
    );
  }
}
