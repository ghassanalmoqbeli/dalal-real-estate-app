import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/test_app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class ReasonFormContent extends StatelessWidget {
  const ReasonFormContent({super.key});

  @override
  Widget build(BuildContext context) {
    return VPItem(
      bSpc: 40,
      child: Text.rich(
        textDirection: WidH.trd,
        textAlign: WidH.tra,
        TextSpan(
          children: [
            TextSpan(text: kReason, style: FStyles.s17w5),
            TextSpan(text: kAIResponse, style: FStyles.s17w4),
          ],
        ),
      ),
    );
  }
}
