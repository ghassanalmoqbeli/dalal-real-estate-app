import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/a_i_predicted_price_item/a_i_price_text_field.dart';
import 'package:dallal_proj/core/constants/test_app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class PredictedPriceItem extends StatelessWidget {
  const PredictedPriceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: 20,
      bSpc: 20,
      child: Container(
        height: 136,
        width: Funcs.frwGetter(368, context),
        padding: const EdgeInsets.only(right: 16, bottom: 20, left: 36),
        decoration: Themer.aiBtn(kPredictedPriceItemColors, 32),
        child: const Center(child: AIPriceTF(price: kPriceTest)),
      ),
    );
  }
}
