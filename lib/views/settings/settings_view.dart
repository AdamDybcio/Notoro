import 'package:flutter/material.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/views/settings/widgets/settings_section.dart';

import 'widgets/theme_settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.settings_outlined,
        title: AppStrings.settings,
      ),
      body: ListView(
        children: const [
          SettingsSection(
            title: AppStrings.general,
            children: [
              ThemeSettingTile(),
              // UnitsSettingTile(),
            ],
          ),
          SettingsSection(
            title: AppStrings.training,
            children: [
              // DefaultRestBetweenSetsTile(),
              // DefaultRestBetweenExercisesTile(),
              // DefaultRepsAndSetsTile(),
            ],
          ),
          SettingsSection(
            title: AppStrings.data,
            children: [
              // ClearAllDataTile(),
              // ExportHistoryTile(),
            ],
          ),
          SettingsSection(
            title: AppStrings.info,
            children: [
              // AboutAppTile(),
            ],
          ),
        ],
      ),
    );
  }
}
