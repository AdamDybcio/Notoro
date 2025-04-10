import 'package:flutter/material.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.settings_outlined,
        title: AppStrings.settings,
      ),
    );
  }
}
