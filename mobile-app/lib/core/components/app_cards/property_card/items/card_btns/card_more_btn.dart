import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:flutter/material.dart';

class CardMoreBtn extends StatelessWidget {
  const CardMoreBtn({
    super.key,
    this.onTap,
    required this.btnSize,
    this.color,
    this.text,
    this.style,
  });
  final void Function()? onTap;
  final XBSize btnSize;
  final Color? color;
  final String? text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ColBtn(
      txt: text ?? kDetails,
      style: style,
      size: btnSize,
      onPressed: onTap,
      deco: Themer.bard(color ?? kPrimColG),
    );
  }
}
