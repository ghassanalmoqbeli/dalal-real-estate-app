import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/gradient_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class IcoGradText extends StatelessWidget {
  final String text;
  final String? ico;
  final TextStyle? style;
  final Gradient gradient;
  final double? tSpc, bSpc, lSpc, rSpc, iHt, iWth;

  const IcoGradText({
    required this.text,
    required this.gradient,
    required this.style,
    super.key,
    this.tSpc,
    this.bSpc,
    this.lSpc,
    this.rSpc,
    this.ico,
    this.iHt,
    this.iWth,
  });

  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: tSpc ?? 0,
      bSpc: bSpc ?? 0,
      child: TwoItmRow(
        mXSize: MainAxisSize.min,
        rightChild: HPItem(
          lSpc: lSpc ?? 0,
          rSpc: rSpc ?? 0,
          child: GradText(
            text: text,
            gradient: gradient,
            style: style ?? FStyles.s16wBh175,
          ),
        ),
        leftChild: SvgIco(
          ico: ico ?? AssetsData.aiIco,
          ht: iHt ?? 24,
          wth: iWth ?? 24,
        ),
      ),
    );
  }
}
