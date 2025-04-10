import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notoro/core/utils/constants/app_const.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';

import '../controllers/navbar/navbar_cubit.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, NavbarItem>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: AppConst.screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) {
              context.read<NavbarCubit>().selectItem(
                    NavbarItem.values[index],
                  );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: AppStrings.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center_outlined),
                label: AppStrings.workout,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                label: AppStrings.history,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: AppStrings.settings,
              ),
            ],
          ),
        );
      },
    );
  }
}
