import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rad_btn.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btn_style_and_decoration/radio_styles.dart';
import 'package:flutter/material.dart';

class CustRadBtn extends StatelessWidget {
  const CustRadBtn({
    super.key,
    required this.isSelected,
    required this.text,
    required this.selectedValue,
  });

  final bool isSelected;
  final String text;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: isSelected ? RStyles.activeRTheme : RStyles.inActiveTheme,
      child: RadBtn(
        scale: 0.8,
        color: kPrimColR2A,
        option: text,
        selectedValue: selectedValue,
        isSelected: isSelected,
      ),
    );
  }
}
