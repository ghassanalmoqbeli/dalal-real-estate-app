import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class AIBtn extends StatelessWidget {
  const AIBtn({
    super.key,
    this.onPressed,
    this.size = const XBSize(width: 367),
  });
  final void Function()? onPressed;
  final XBSize size;

  @override
  Widget build(BuildContext context) {
    return ColBtn(
      txt: kPredictPriceAiBtn,
      onPressed: onPressed,
      size: size,
      deco: Themer.aiBtn(null, null),
    );
  }
}
