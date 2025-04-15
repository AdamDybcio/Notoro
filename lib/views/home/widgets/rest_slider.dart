import 'package:flutter/material.dart';

import '../../../core/utils/strings/app_strings.dart';

class RestSlider extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const RestSlider({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: $value ${AppStrings.sec}',
            style: Theme.of(context).textTheme.labelMedium),
        Slider(
          value: value.toDouble(),
          min: 15,
          max: 180,
          divisions: 11,
          label: '$value ${AppStrings.secVeryShort}',
          onChanged: (val) => onChanged(val.round()),
        ),
      ],
    );
  }
}
