import 'package:dallal_proj/features/home_page/presentation/views/widgets/home_app_bar/items/home_app_bar_icos.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.favOnPressed,
    this.notifOnPressed,
    this.hasUnread = false,
  });
  final void Function()? favOnPressed, notifOnPressed;
  final bool hasUnread;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 16.0, left: 20.0),
        child: HomeAppBarIcos(
          favOnPressed: favOnPressed,
          notifOnPressed: notifOnPressed,
          hasUnread: hasUnread,
        ),
      ),
    );
  }
}
