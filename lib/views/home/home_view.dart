import 'package:flutter/material.dart';
import 'package:notoro/core/common/widgets/main_appbar.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';

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
    );
  }
}
