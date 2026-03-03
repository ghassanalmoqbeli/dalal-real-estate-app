import 'package:dallal_proj/core/components/app_cards/property_card/items/card_details/right_ico_line.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class PredictedPriceTFTitle extends StatelessWidget {
  const PredictedPriceTFTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return VPItem(
      bSpc: 12,
      child: RightIcoLine(
        text: kPredictedPrice,
        icoHt: 24,
        icoWth: 24,
        itSpc: 4,
        icoPath: AssetsData.predictAi,
        style: FStyles.s15w6,
      ),
    );
  }
}
