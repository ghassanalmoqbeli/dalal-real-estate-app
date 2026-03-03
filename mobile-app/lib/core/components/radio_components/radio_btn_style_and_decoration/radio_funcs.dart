import 'package:dallal_proj/core/components/radio_components/radio_builder_box.dart';
import 'package:flutter/material.dart';

class RFnc {
  static List<Widget> buildTrol({
    required List<String> options,
    required String selectedValue,
    required void Function(String) onTapped,
    required Widget Function(bool isSelected, String option) childBuilder,
  }) {
    /// Trol <=> Text Radio Options List
    return options.map((option) {
      final bool isSelected = selectedValue == option;
      return RadBuilderBox(
        option: option,
        onTapped: onTapped,
        child: childBuilder(isSelected, option),
      );
    }).toList();
  }
}
