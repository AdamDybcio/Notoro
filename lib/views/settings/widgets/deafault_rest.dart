import 'package:flutter/material.dart';

class DefaultRestBetweenSetsTile extends StatelessWidget {
  const DefaultRestBetweenSetsTile({super.key});

  @override
  Widget build(BuildContext context) {
    // final box = Hive.box('app_settings');

    // return ValueListenableBuilder(
    //   valueListenable: box.listenable(keys: ['default_rest_sets']),
    //   builder: (context, Box settings, _) {
    //     final currentValue =
    //         settings.get('default_rest_sets', defaultValue: 90);

    //     return ListTile(
    //       title: const Text(AppStrings.defaultRestBetweenSets),
    //       subtitle: Text('$currentValue ${AppStrings.seconds}'),
    //       trailing: const Icon(Icons.timer_outlined),
    //       onTap: () async {
    //         final result = await showDialog<int>(
    //           context: context,
    //           builder: (_) => NumberPickerDialog(
    //             title: AppStrings.chooseRest,
    //             initialValue: currentValue,
    //             minValue: 15,
    //             maxValue: 180,
    //             step: 15,
    //           ),
    //         );

    //         if (result != null) {
    //           settings.put('default_rest_sets', result);
    //         }
    //       },
    //     );
    //   },
    // );
    return SizedBox.shrink();
  }
}
