import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_shadows.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:flutter/material.dart';

class BtnHelpers {
  static Decoration btn(
    double? radius, {
    double? borderWidth,
    XBColors? colors,
  }) {
    final cols = colors ?? const XBColors();
    final bool isNull = borderWidth == null;

    return Themer.genShape(
      color: cols.fill,
      rad: radius,
      side: Themer.brdSide(
        color: cols.border,
        width: borderWidth,
        brdStyle: Themer.getBrdStyle(isNull),
      ),
      shadows: [Shads.shadowbtn],
    );
  }

  static Decoration btnWhite() =>
      Themer.genShape(color: kWhite, side: Themer.brdSide(width: 0.5));

  static Decoration btnCol(Color? fillCol) =>
      Themer.genShape(color: fillCol ?? kPrimColG, shadows: [Shads.shadow12]);
}
