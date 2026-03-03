import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Shads {
  // Common BoxShadow styles
  static BoxShadow shadow2(Color? fillColor) => BoxShadow(
    color: fillColor ?? kBlack28,
    blurRadius: 2,
    offset: const Offset(0, 1),
    spreadRadius: 0,
  );

  static const shadow4 = BoxShadow(
    color: kBlackX28,
    blurRadius: 4,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );

  static const shadowbtn = BoxShadow(
    color: Colors.black54,
    blurRadius: 3,
    offset: Offset(0, 2),
  );

  static const shadow5 = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 5,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );
  static const shadow8 = BoxShadow(
    color: kBlackX19,
    blurRadius: 8,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  static const shadow12 = BoxShadow(
    color: kTransP,
    blurRadius: 12,
    offset: Offset(0, 2),
    spreadRadius: 0,
  ); //unused
}
