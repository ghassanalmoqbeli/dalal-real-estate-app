import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class NtfHelper {
  static ShapeDecoration notificOutLine({Color? bgColor}) => Themer.genShape(
    color: bgColor ?? kWhiteT6,
    side: Themer.brdSide(color: kBlackX33),
  );
}
