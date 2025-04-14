import 'package:flutter/material.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:notoro/views/home/widgets/today_workout_banner.dart';
import 'package:notoro/views/home/widgets/weekly_plan_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        leadingIcon: Icons.home_outlined,
        title: AppStrings.homePage,
        showLogo: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TodayWorkoutBanner(),
            SizedBox(height: 20),
            WeeklyPlanSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
