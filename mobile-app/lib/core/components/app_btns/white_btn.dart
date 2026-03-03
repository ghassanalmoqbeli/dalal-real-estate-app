import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/app_btns/btn_helpers.dart';
import 'package:dallal_proj/core/components/app_btns/models/btn_model.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/components/app_btns/bases/base_btn.dart';

class WhiteBtn extends BaseBtn {
  const WhiteBtn({
    this.style,
    super.key,
    required this.txt,
    this.size = const XBSize(width: 367, border: 0.5),
    this.onPressed,
  });

  final XBSize size;
  final String txt;
  final TextStyle? style;
  final void Function()? onPressed;

  @override
  BtnModel buildModel(BuildContext context) {
    return BtnModel(
      text: txt,
      onPressed: onPressed,
      btnSize: size,
      btnColors: const XBColors(border: kBlack, fill: kWhite, txt: kBlack),
      txtStyle: style ?? FStyles.s18w6,
      deco: BtnHelpers.btnWhite(),
    );
  }
}
