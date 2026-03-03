import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

TextSpan linkTextSpan({
  required BuildContext context,
  required String text,
  VoidCallback? onTap,
  TextStyle? style,
}) {
  return TextSpan(
    text: text,
    style: style ?? FsC.colStG(FStyles.s14W5),
    recognizer: TapGestureRecognizer()..onTap = onTap,
  );
}
