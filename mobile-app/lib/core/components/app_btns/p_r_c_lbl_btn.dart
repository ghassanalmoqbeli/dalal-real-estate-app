import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/components/app_btns/btn_flex_box.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/p_r_c_lbl_txt.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';

class PRCLblBtn extends StatelessWidget {
  const PRCLblBtn({
    super.key,
    required this.color,
    this.preTxt = ' ',
    this.onTap,
    this.txt,
    required this.lblSize,
    this.border,
    required this.style,
  });
  final Color color;
  final XBSize lblSize;
  final double? border;
  final String preTxt;
  final String? txt;
  final TextStyle style;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return BtnFlexBox(
      btnCols: XBColors(fill: color, txt: kWhite),
      deco: Themer.bard(color, borderWidth: border),
      onTap: onTap,
      btnSize: lblSize,
      child: PRCLblTxt(txt: txt, preTxt: preTxt, style: style),
    );
  }
}
