import 'package:dallal_proj/core/widgets/text_widgets/d_text.dart';
import 'package:flutter/material.dart';

class DynamicText extends StatelessWidget {
  const DynamicText({
    super.key,
    this.hPadding,
    required this.txt,
    this.style,
    this.txtAlign,
  });
  final double? hPadding;
  final String txt;
  final TextStyle? style;
  final TextAlign? txtAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding ?? 0.0),
      child: DText(txt: txt, style: style, txtAlign: txtAlign),
    );
  }
}
