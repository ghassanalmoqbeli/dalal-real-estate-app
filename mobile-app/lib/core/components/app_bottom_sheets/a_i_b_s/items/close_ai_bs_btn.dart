import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class CloseAiBsBtn extends StatelessWidget {
  const CloseAiBsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: 40,
      bSpc: 26,
      child: ColBtn(
        txt: kClose,
        size: const XBSize(),
        deco: Themer.aiBtn(kPredictedPriceItemColors, 8),
      ),
    );
  }
}
