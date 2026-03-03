import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/a_i_predicted_price_item/predicted_price_input.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/a_i_predicted_price_item/predicted_price_t_f_title.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:flutter/material.dart';

class AIPriceTF extends StatelessWidget {
  const AIPriceTF({super.key, this.price});
  final String? price;

  @override
  Widget build(BuildContext context) {
    return TwoItmCol(
      cXAlign: CrossAxisAlignment.end,
      mXSize: MainAxisSize.min,
      topChild: const PredictedPriceTFTitle(),
      btmChild: PredictedPriceInput(price: price),
    );
  }
}
