import 'package:flutter/material.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btn_style_and_decoration/radio_decorations.dart';

class RadBtn extends StatelessWidget {
  const RadBtn({
    super.key,
    required this.option,
    required this.selectedValue,
    this.onChanged,
    required this.isSelected,
    this.color = kPrimColG,
    this.scale = 0.8,
  });
  final bool isSelected;
  final String option, selectedValue;
  final Color color;
  final void Function(String?)? onChanged;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Radio<String>(
        fillColor: RBDeco.fillClr(isSelected, color),
        value: option,
        groupValue: selectedValue,
        onChanged: onChanged,
        activeColor: isSelected ? color : kGrey,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
