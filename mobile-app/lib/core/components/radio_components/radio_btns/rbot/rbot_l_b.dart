import 'package:dallal_proj/core/components/radio_components/radio_btn_style_and_decoration/radio_funcs.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rbot/rbot.dart';
import 'package:flutter/material.dart';

class RbotLB extends StatelessWidget {
  /// RbotLB <=> Radio Btns Outer-Text ListBuilder
  const RbotLB({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onTapped, //this.onChanged,
  });
  final String selectedValue;
  final List<String> options;
  final ValueChanged<String> onTapped;
  // final void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: RFnc.buildTrol(
          options: options,
          selectedValue: selectedValue,
          onTapped: onTapped,
          childBuilder:
              (isSelectedV, option) => Rbot(
                text: option,
                selectedValue: selectedValue,
                isSelected: isSelectedV,
              ),
        ),
      ),
    );
  }
}
