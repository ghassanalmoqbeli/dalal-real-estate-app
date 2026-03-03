import 'package:dallal_proj/core/widgets/text_widgets/v_p_text.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/details_desc_box.dart';
import 'package:flutter/material.dart';

class AdvAdviseSection extends StatelessWidget {
  const AdvAdviseSection({
    super.key,
    this.btmSpacing = 10,
    this.topSpacing = 10,
    this.mXAlign = MainAxisAlignment.end,
    required this.style,
    required this.advices,
  });
  final List<String> advices;

  final double btmSpacing, topSpacing;
  final MainAxisAlignment mXAlign;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return DetailDescBox(
      children: [
        VPText(
          txt: advices[0],
          bSpc: btmSpacing,
          tSpc: 10,
          mXAlign: mXAlign,
          style: style,
        ),
        VPText(
          txt: advices[1],
          bSpc: btmSpacing,
          mXAlign: mXAlign,
          style: style,
        ),
        VPText(
          txt: advices[2],
          bSpc: btmSpacing,
          mXAlign: mXAlign,
          style: style,
        ),
        VPText(txt: advices[3], bSpc: 10, mXAlign: mXAlign, style: style),
      ],
    );
  }
}
