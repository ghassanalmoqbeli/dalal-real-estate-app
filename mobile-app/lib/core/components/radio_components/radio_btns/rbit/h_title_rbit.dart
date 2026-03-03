import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rbit/rbit_l_b.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class HTitleRbit extends StatelessWidget {
  const HTitleRbit({
    super.key,
    required this.selectedOpt,
    required this.olModel,
    this.mXAlign = MainAxisAlignment.spaceBetween,
    this.rItmSpc = 0,
    this.rTxtSpc = 8,
    required this.titleStyle,
    required this.titleAlign,
    this.onTapped,
  });
  final ValueNotifier<String> selectedOpt;
  final TextStyle titleStyle;
  final TextAlign titleAlign;
  final OptionsListModel olModel;
  final MainAxisAlignment mXAlign;
  final double rItmSpc, rTxtSpc;
  final Function(String)? onTapped;
  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: mXAlign,
      leftChild: HPItem(
        rSpc: rItmSpc,
        child: RbitLB(
          selectedValueNotifier: selectedOpt,
          width: rTxtSpc,
          options: olModel.options,
          onTapped: onTapped ?? (value) => selectedOpt.value = value,
        ),
      ),
      rightChild: RText(olModel.title, titleStyle, txtAlign: titleAlign),
    );
  }
}
