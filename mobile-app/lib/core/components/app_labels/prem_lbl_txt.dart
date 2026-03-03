import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';

class PremLblTxt extends StatelessWidget {
  const PremLblTxt({super.key, required this.style, required this.txt});
  final TextStyle style;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return RText(txt, style, txtAlign: TextAlign.right);
  }
}
