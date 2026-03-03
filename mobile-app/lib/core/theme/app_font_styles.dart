import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:flutter/material.dart';

abstract class FStyles {
  static var fSemiB = const TextStyle(fontWeight: FontWeight.w600); //unused
  static var fBold = const TextStyle(fontWeight: FontWeight.w700); //unused
  static var fMed = const TextStyle(fontWeight: FontWeight.w500);

  static var s50W6 = const TextStyle(fontWeight: FontWeight.w600, fontSize: 50);

  static var s25w6 = const TextStyle(fontSize: 25, fontWeight: FontWeight.w600);

  static var s24w6 = const TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

  static var s20w6 = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  static var s18wB = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static var s18w6 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static var s18w4 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  static var s17w5 = const TextStyle(fontSize: 17, fontWeight: FontWeight.w500);

  static var s17w4 = const TextStyle(fontSize: 17, fontWeight: FontWeight.w400);

  static var s16wB = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  static var s16wBh175 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.75,
  );

  static var s16w6h175 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.75,
  );

  static var s16w5h175 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.75,
  );

  static var s16w5 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static var s16w4 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static var s15w6 = const TextStyle(fontSize: 15, fontWeight: FontWeight.w600);

  static var s14wB = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

  static var s14w6 = const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  static var s14W5 = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  static var s14W4 = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  static var s12wB = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

  static var s12w5 = const TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  static var gNavBtn = FsC.colStG(s12w5).copyWith(letterSpacing: 0.01);

  static var whNavBtn = FsC.colStW(FStyles.s12w5).copyWith(letterSpacing: 0.01);

  static var s12w5h1o6 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );

  static var s12w4 = const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  static var s10wB = const TextStyle(fontSize: 10, fontWeight: FontWeight.bold);

  static var s10w6 = const TextStyle(fontSize: 10, fontWeight: FontWeight.w600);

  static var s10w5h1o6 = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );

  static var s10w4 = const TextStyle(fontSize: 10, fontWeight: FontWeight.w400);
}
