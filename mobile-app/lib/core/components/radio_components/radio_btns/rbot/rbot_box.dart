import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/components/radio_components/r_label.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/cust_rad_btn.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class RbotBox extends StatelessWidget {
  const RbotBox({
    super.key,
    required this.text,
    required this.selectedValue,
    required this.isSelected,
  });
  final String text;
  final String selectedValue;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TwoItmRow(
        mXAlign: MainAxisAlignment.end,
        leftChild: HPItem(
          rSpc: 8,
          child: RLabel(
            isSelected: isSelected,
            lblTxt: text,
            color: kBlack,
            fSize: 16,
          ),
        ),
        rightChild: CustRadBtn(
          isSelected: isSelected,
          text: text,
          selectedValue: selectedValue,
        ),
      ),
    );
  }
}
