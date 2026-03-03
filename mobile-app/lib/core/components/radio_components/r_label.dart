import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RLabel extends StatelessWidget {
  const RLabel({
    super.key,
    required this.isSelected,
    required this.lblTxt,
    this.color,
    this.fSize,
  });

  final String lblTxt;
  final bool isSelected;
  final Color? color;
  final double? fSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      lblTxt,
      textAlign: WidH.tra,
      style: TextStyle(
        fontSize: fSize ?? 9.5,
        fontWeight: FontWeight.w500,
        color: isSelected ? color ?? kPrimColG : Colors.black87,
        // height: 1.0,
      ),
    );
  }
}
