import 'package:dallal_proj/core/components/radio_components/r_label.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btn_style_and_decoration/radio_styles.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rad_btn.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class RbitBox extends StatelessWidget {
  const RbitBox({
    super.key,
    required this.text,
    required this.selectedValue,
    required this.isSelected,
    required this.width,
  });
  final String text;
  final String selectedValue;
  final bool isSelected;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isSelected ? RStyles.activeTheme : RStyles.inActiveTheme,
      child: TwoItmRow(
        rightChild: RadBtn(
          option: text,
          selectedValue: selectedValue,
          isSelected: isSelected,
        ),
        leftChild: HPItem(
          lSpc: width,
          child: RLabel(isSelected: isSelected, lblTxt: text, fSize: 9.5),
        ),
      ),
    );
  }
}
