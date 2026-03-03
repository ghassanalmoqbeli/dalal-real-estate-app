import 'package:dallal_proj/core/components/radio_components/radio_btns/rbot/rbot_box.dart';
import 'package:flutter/material.dart';

class Rbot extends StatelessWidget {
  /// Rbot <=> Radio Btns Outer Text
  const Rbot({
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
    return RbotBox(
      text: text,
      selectedValue: selectedValue,
      isSelected: isSelected,
    );
  }
}
