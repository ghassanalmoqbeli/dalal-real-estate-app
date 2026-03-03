import 'package:dallal_proj/core/components/radio_components/radio_btns/rbit/rbit_box.dart';
import 'package:flutter/material.dart';

class Rbit extends StatelessWidget {
  /// Rbit <=> Radio Btns Inner Text
  const Rbit({
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
    return RbitBox(
      text: text,
      selectedValue: selectedValue,
      isSelected: isSelected,
      width: width,
    );
  }
}
