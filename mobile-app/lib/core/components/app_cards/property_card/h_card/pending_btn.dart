import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/app_btns/p_r_c_lbl_btn.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';

class PendingBtn extends StatelessWidget {
  const PendingBtn({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return PRCLblBtn(
      lblSize: const XBSize(width: 139, height: 29),
      style: FsC.colStW(FStyles.s10wB),
      color: kPrimColO,
      preTxt: kUnderReview,
      onTap: onTap,
    );
  }
}
