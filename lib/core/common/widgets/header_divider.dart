import 'package:flutter/material.dart';

class HeaderDivider extends StatelessWidget {
  final String text;
  const HeaderDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: const Divider(
            thickness: 1,
            height: 20,
          ),
        ),
      ],
    );
  }
}
