import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:flutter/material.dart';

class LanDetector {
  static TextDirection detectDir({required String? text}) =>
      isArDir(isAr: isItAr(text: text));

  static TextDirection isArDir({required bool isAr}) =>
      isAr ? TextDirection.rtl : TextDirection.ltr;

  static bool isItAr({required String? text}) {
    if (text != null && text.isNotEmpty) {
      return (RegExp(kDefArRegex).hasMatch(text));
    }
    return true;
  }

  static TextAlign detectAlign({required String? text}) =>
      isArAl(isAr: isItAr(text: text));

  static TextAlign isArAl({required bool isAr}) =>
      isAr ? TextAlign.right : TextAlign.left;
}
