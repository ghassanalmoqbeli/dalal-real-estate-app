import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class SBx {
  static SizedBox rHsbx(double fract, BuildContext context) =>
      SizedBox(height: Funcs.frhGetter(fract, context));

  static SizedBox rWsbx(double fract, BuildContext context) => SizedBox(
    width: Funcs.frwGetter(
      Funcs.respWidth(fract: fract, context: context),
      context,
    ),
  );
  static var h05 = const SizedBox(height: 5);
  static var h10 = const SizedBox(height: 10);
  static var h15 = const SizedBox(height: 15);
  static var h20 = const SizedBox(height: 20);
  static var h25 = const SizedBox(height: 25);
  static var h30 = const SizedBox(height: 30);
  static var h32 = const SizedBox(height: 32);
  static var h40 = const SizedBox(height: 40);
  static var w05 = const SizedBox(width: 5);
  static var w10 = const SizedBox(width: 10);
  static var w15 = const SizedBox(width: 15);
  static var w20 = const SizedBox(width: 20);
  static var w25 = const SizedBox(width: 25);
  static var w30 = const SizedBox(width: 30);
  static var w40 = const SizedBox(width: 40);
}
