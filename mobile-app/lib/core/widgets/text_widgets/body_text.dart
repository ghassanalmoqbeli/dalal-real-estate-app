import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';

class BodyTxt extends StatelessWidget {
  const BodyTxt({super.key, required this.text, this.tAln, this.style});
  final TextAlign? tAln;
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return RText(
      text,
      style ?? FStyles.s16w5h175,
      txtAlign: tAln ?? TextAlign.center,
    );
  }
}
