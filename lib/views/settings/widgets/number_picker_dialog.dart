import 'package:flutter/material.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';

class NumberPickerDialog extends StatefulWidget {
  final String title;
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;

  const NumberPickerDialog({
    super.key,
    required this.title,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    this.step = 1,
  });

  @override
  State<NumberPickerDialog> createState() => _NumberPickerDialogState();
}

class _NumberPickerDialogState extends State<NumberPickerDialog> {
  late int selected;

  @override
  void initState() {
    selected = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: DropdownButton<int>(
        value: selected,
        isExpanded: true,
        dropdownColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        menuMaxHeight: 300,
        items: List.generate(
          ((widget.maxValue - widget.minValue) ~/ widget.step) + 1,
          (index) {
            final value = widget.minValue + (index * widget.step);
            return DropdownMenuItem(
              value: value,
              child: Text('$value ${AppStrings.seconds}'),
            );
          },
        ),
        onChanged: (value) => setState(() => selected = value!),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel)),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, selected),
          child: const Text(AppStrings.save),
        )
      ],
    );
  }
}
