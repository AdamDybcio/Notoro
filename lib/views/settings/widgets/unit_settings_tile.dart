import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:provider/provider.dart';

class UnitsSettingTile extends StatelessWidget {
  const UnitsSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUnit =
        context.watch<SettingsNotifier>().settings.preferredUnit;

    return ListTile(
      title: const Text(AppStrings.weightUnit),
      subtitle: Text(currentUnit.toUpperCase()),
      leading: const Icon(Icons.scale_outlined),
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (_) => const _UnitsBottomSheet(),
      ),
    );
  }
}

class _UnitsBottomSheet extends StatelessWidget {
  const _UnitsBottomSheet();

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<SettingsNotifier>();
    final selected = notifier.settings.preferredUnit;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text(AppStrings.chooseUnit)),
          RadioListTile(
            title: const Text(AppStrings.kgFull),
            value: AppStrings.kg,
            groupValue: selected,
            onChanged: (val) {
              notifier.updatePreferredUnit(val!);
              Navigator.pop(context);
            },
          ),
          RadioListTile(
            title: const Text(AppStrings.lbFull),
            value: AppStrings.lb,
            groupValue: selected,
            onChanged: (val) {
              notifier.updatePreferredUnit(val!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
