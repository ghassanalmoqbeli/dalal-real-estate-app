import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:flutter/material.dart';

class RText extends StatelessWidget {
  const RText(this.text, this.style, {super.key, this.txtAlign, this.tOvrFlw});
  final String text;
  final TextStyle? style;
  final TextAlign? txtAlign;
  final TextOverflow? tOvrFlw;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: WidH.trd,
      textAlign: txtAlign,
      style: style,
      overflow: tOvrFlw,
    );
  }
}
