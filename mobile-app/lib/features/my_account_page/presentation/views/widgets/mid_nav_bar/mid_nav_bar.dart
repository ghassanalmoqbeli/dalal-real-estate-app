import 'package:dallal_proj/core/constants/str_lists.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/mid_nav_bar/nav_btn.dart';
import 'package:flutter/material.dart';

class MidNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onNavTap;

  const MidNavBar({
    super.key,
    required this.selectedIndex,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return NavBtn(
            isSelected: selectedIndex == 2 - i,
            btnTxt: CLstr.midNavLbls[2 - i],
            isLeft: Funcs.isLeft(i),
            onTap: () => onNavTap(2 - i),
          );
        }),
      ),
    );
  }
}
