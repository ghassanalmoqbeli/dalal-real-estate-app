import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class McCheckboxItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onToggle;
  final double checkboxScale;
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final TextStyle textStyle;

  const McCheckboxItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onToggle,
    required this.checkboxScale,
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 5,
      onTap: () => onToggle(!isSelected),
      child: TwoItmRow(
        mXSize: MainAxisSize.min,
        leftChild: Text(label, style: textStyle),
        rightChild: HPItem(
          rSpc: 10,
          child: Transform.scale(
            scale: checkboxScale,
            child: Checkbox(
              value: isSelected,
              onChanged: (val) => onToggle(val ?? false),
              activeColor: activeColor,
              checkColor: checkColor,
              side: BorderSide(color: borderColor, width: 1.5),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ),
    );
  }
}
