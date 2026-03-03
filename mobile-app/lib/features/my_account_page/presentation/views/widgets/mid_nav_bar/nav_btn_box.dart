import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/mid_nav_bar/mid_nav_helper.dart';
import 'package:dallal_proj/features/my_account_page/presentation/views/widgets/mid_nav_bar/nav_btn_text.dart';
import 'package:flutter/material.dart';

class NavBtnBox extends StatelessWidget {
  const NavBtnBox({
    super.key,
    required this.onTap,
    required this.isLeft,
    required this.btnTxt,
    required this.isSelected,
  });

  final void Function()? onTap;
  final bool? isLeft;
  final bool isSelected;
  final String btnTxt;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 130 / 40,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: MidNavHelper.btnLR(isLeft, isSelected),
          child: NavBtnText(text: btnTxt, isSelected: isSelected),
        ),
      ),
    );
  }
}
