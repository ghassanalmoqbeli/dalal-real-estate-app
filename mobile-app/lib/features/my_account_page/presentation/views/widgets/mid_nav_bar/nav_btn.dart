import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/mid_nav_bar/nav_btn_box.dart';
import 'package:flutter/material.dart';

class NavBtn extends StatelessWidget {
  const NavBtn({
    super.key,
    this.onTap,
    this.isLeft,
    required this.btnTxt,
    required this.isSelected,
  });
  final void Function()? onTap;
  final bool? isLeft;
  final bool isSelected;
  final String btnTxt;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NavBtnBox(
        onTap: onTap,
        isLeft: isLeft,
        btnTxt: btnTxt,
        isSelected: isSelected,
      ),
    );
  }
}
