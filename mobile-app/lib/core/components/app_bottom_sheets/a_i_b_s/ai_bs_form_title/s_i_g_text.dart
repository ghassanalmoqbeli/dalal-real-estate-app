import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/ai_bs_form_title/ico_grad_text.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:flutter/material.dart';

class SIGText extends StatelessWidget {
  final String text;
  final String? ico;
  final TextStyle? style;
  final Gradient gradient;
  final double? tSpc, bSpc, lSpc, rSpc, iHt, iWth;

  const SIGText({
    required this.text,
    required this.gradient,
    this.style,
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
      bSpc: 20,
      child: TwoItmCol(
        topChild: IcoGradText(
          text: text,
          gradient: gradient,
          style: style,
          tSpc: tSpc,
          bSpc: bSpc,
          iHt: iHt,
          iWth: iWth,
          ico: ico,
          lSpc: lSpc,
          rSpc: rSpc,
        ),
        btmChild: WidH.respSep(context),
      ),
    );
  }
}
