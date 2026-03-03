import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';

class RightMainTitle extends StatelessWidget {
  const RightMainTitle({super.key, required this.text, this.isRight = true});
  final String text;
  final bool isRight;
  @override
  Widget build(BuildContext context) {
    return isRight
        ? Align(
          alignment: Alignment.centerRight,
          child: RText(text, FStyles.s14wB, txtAlign: TextAlign.right),
        )
        : RText(text, FStyles.s25w6, txtAlign: TextAlign.center);
  }
}
