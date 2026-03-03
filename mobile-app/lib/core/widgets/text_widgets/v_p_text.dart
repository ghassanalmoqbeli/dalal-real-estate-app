import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class VPText extends StatelessWidget {
  const VPText({
    super.key,
    required this.txt,
    this.bSpc = 0,
    this.tSpc = 0,
    this.style,
    this.mXAlign = MainAxisAlignment.end,
  });

  final String txt;
  final TextStyle? style;
  final MainAxisAlignment mXAlign;
  final double bSpc, tSpc;

  @override
  Widget build(BuildContext context) {
    return VPItem(
      bSpc: bSpc,
      tSpc: tSpc,
      child: AText(txt: txt, mXAlign: mXAlign, style: style),
    );
  }
}
