import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/app_btns/bases/base_btn.dart';
import 'package:dallal_proj/core/components/app_btns/btn_helpers.dart';
import 'package:dallal_proj/core/components/app_btns/models/btn_model.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';

class ColBtn extends BaseBtn {
  const ColBtn({
    this.deco,
    this.style,
    super.key,
    required this.txt,
    this.size = const XBSize(width: 367),
    this.onPressed,
    this.color = kPrimColG,
  });

  final Color color;
  final XBSize size;
  final String txt;
  final Decoration? deco;
  final TextStyle? style;
  final void Function()? onPressed;

  @override
  BtnModel buildModel(BuildContext context) {
    return BtnModel(
      text: txt,
      onPressed: onPressed,
      btnSize: size,
      txtStyle: style ?? FsC.colStW(FStyles.s18w6),
      deco: deco ?? BtnHelpers.btnCol(color),
    );
  }
}
