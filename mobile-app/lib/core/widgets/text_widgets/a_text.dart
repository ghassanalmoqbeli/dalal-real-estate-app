import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';

class AText extends StatelessWidget {
  const AText({
    super.key,
    required this.txt,
    this.style,
    this.mXAlign = MainAxisAlignment.center,
    this.mXSize = MainAxisSize.max,
  });
  final String txt;
  final TextStyle? style;
  final MainAxisAlignment mXAlign;
  final MainAxisSize mXSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mXSize,
      mainAxisAlignment: mXAlign,
      children: [RText(txt, style, tOvrFlw: TextOverflow.ellipsis)],
    );
  }
}
