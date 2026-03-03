import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/a_i_predicted_price_item/predicted_price_item.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/ai_bs_form_title/ai_bs_form_title.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/items/close_ai_bs_btn.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/items/reason_form_content.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:flutter/material.dart';

class AIForm extends StatelessWidget {
  const AIForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AiBsFormTitle(),
        VPItem(
          bSpc: 30,
          child: TwoItmCol(
            topChild: const PredictedPriceItem(),
            btmChild: WidH.respSep(context),
          ),
        ),
        const ReasonFormContent(),
        const CloseAiBsBtn(),
      ],
    );
  }
}
