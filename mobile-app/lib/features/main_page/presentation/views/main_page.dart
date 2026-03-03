import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/features/main_page/presentation/views/widgets/bottom_navigation_bar/nv_bar_funcs.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PersistentTabController controller;

  @override
  void initState() {
    controller = PersistentTabController(initialIndex: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: NvBar.screens(),
      items: NvBar.items(),
      navBarHeight: 64,
      navBarStyle: NavBarStyle.style1, //9, 1
      backgroundColor: kWhite,
      confineToSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      animationSettings: NvBar.animationSettings(),
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
