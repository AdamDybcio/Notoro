import 'package:flutter/material.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final String title;
  final bool showLogo;
  const MainAppbar({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.showLogo = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      leading: !showLogo
          ? Icon(
              leadingIcon,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            )
          : Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/branding/app_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
