import 'package:flutter/material.dart';
import 'package:notoro/core/common/widgets/empty_state_widget.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.history_outlined,
        title: AppStrings.history,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          children: [
            EmptyStateWidget(
              title: AppStrings.noHistoryTitle,
              subtitle: AppStrings.noHistorySubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
