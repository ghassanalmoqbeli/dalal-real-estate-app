import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/v_p_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:flutter/material.dart';

class SeperatedTitle extends StatelessWidget {
  const SeperatedTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return TwoItmCol(
      mXSize: MainAxisSize.min,
      topChild: VPText(
        txt: text,
        style: FStyles.s16wBh175,
        bSpc: 10,
        tSpc: 20,
        mXAlign: MainAxisAlignment.center,
      ),
      btmChild: VPItem(bSpc: 20, child: WidH.respSep(context)),
    );
  }
}
