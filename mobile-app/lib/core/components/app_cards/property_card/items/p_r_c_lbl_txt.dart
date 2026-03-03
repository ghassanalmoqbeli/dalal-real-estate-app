import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:flutter/material.dart';

class PRCLblTxt extends StatelessWidget {
  const PRCLblTxt({
    super.key,
    required this.txt,
    required this.preTxt,
    required this.style,
  });

  final String? txt;
  final String preTxt;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return AText(
      mXAlign: MainAxisAlignment.center,
      txt: txt ?? '$preTxt $kSepDetails',
      style: style,
    );
  }
}
