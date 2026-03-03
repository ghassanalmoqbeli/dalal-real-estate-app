import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_shadows.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class DetsHelper {
  static ShapeDecoration getDescBoxShape({
    Color? backColor,
    Color? brdrColor,
    Color? shadowColor,
    double? brdrWidth,
    double? brdrRad,
  }) => Themer.genShape(
    color: backColor ?? kGrite,
    rad: brdrRad ?? 6,
    side: Themer.brdSide(color: brdrColor, width: brdrWidth ?? 1),
    shadows: [Shads.shadow2(shadowColor)],
  );
}
