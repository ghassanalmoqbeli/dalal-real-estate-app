import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';

class FsC {
  static TextStyle colSt(TextStyle style, Color color) =>
      style.copyWith(color: color);

  static TextStyle colStW(TextStyle style) => style.copyWith(color: kWhite);

  static TextStyle colStR35(TextStyle style) =>
      style.copyWith(color: kPrimColR35);

  static TextStyle colStH(TextStyle style) => style.copyWith(color: kGrey);

  static TextStyle colStH60(TextStyle style) => style.copyWith(color: kGrey60);

  static TextStyle colStB(TextStyle style) => style.copyWith(color: kBlack);

  static TextStyle colStG(TextStyle style) => style.copyWith(color: kPrimColG);

  static TextStyle fntSt(TextStyle style, double fontSize) =>
      style.copyWith(fontSize: fontSize);

  static TextStyle htStyle(TextStyle style, double height) =>
      style.copyWith(height: height);

  static TextStyle premiumLabelTextStyle(double fontSize) =>
      FsC.colSt(FStyles.fMed, kPrimColY).copyWith(fontSize: fontSize);
}
