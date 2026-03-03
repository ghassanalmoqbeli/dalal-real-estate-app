import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/v_p_text.dart';
import 'package:flutter/material.dart';

class VDescItem extends StatelessWidget {
  const VDescItem({
    super.key,
    required this.head,
    required this.tail,
    this.hStyle,
    this.bStyle,
    this.tStyle,
    this.body,
  });

  final String head;
  final String tail;
  final TextStyle? hStyle, bStyle, tStyle;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        VPText(txt: head, style: hStyle ?? FStyles.s14w6, bSpc: 5),
        if (body != null) RText(body!, bStyle),
        VPItem(tSpc: 5, child: RText(tail, tStyle, txtAlign: TextAlign.right)),
      ],
    );
  }
}
