import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:flutter/material.dart';

class HPText extends StatelessWidget {
  const HPText({
    super.key,
    required this.txt,
    this.rSpc = 0,
    this.lSpc = 0,
    this.style,
    this.mXAlign = MainAxisAlignment.center,
  });

  final String txt;
  final TextStyle? style;
  final MainAxisAlignment mXAlign;
  final double rSpc, lSpc;

  @override
  Widget build(BuildContext context) {
    return HPItem(
      rSpc: rSpc,
      lSpc: lSpc,
      child: AText(
        txt: txt,
        mXAlign: mXAlign,
        mXSize: MainAxisSize.min,
        style: style,
      ),
    );
  }
}

class HPPPText extends StatelessWidget {
  const HPPPText({
    super.key,
    required this.txt,
    this.rSpc = 0,
    this.lSpc = 0,
    this.style,
    this.mXAlign = MainAxisAlignment.center,
  });

  final String txt;
  final TextStyle? style;
  final MainAxisAlignment mXAlign;
  final double rSpc, lSpc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: HPItem(rSpc: rSpc, lSpc: lSpc, child: Text(txt, style: style)),
    );
  }
}
