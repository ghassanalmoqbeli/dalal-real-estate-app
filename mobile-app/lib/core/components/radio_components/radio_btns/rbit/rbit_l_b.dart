import 'package:dallal_proj/core/components/radio_components/radio_btn_style_and_decoration/radio_funcs.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rbit/rbit.dart';

class RbitLB extends StatelessWidget {
  /// RbitLB <=> Radio Btns Inner Text List Builder
  const RbitLB({
    super.key,
    required this.options,
    required this.onTapped,
    required this.width,
    required this.selectedValueNotifier,
  });
  final List<String> options;
  final ValueChanged<String> onTapped;
  final double width;
  final ValueNotifier<String> selectedValueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedValueNotifier,
      builder: (context, selectedValue, child) {
        return Row(
          children: RFnc.buildTrol(
            options: options,
            selectedValue: selectedValue,
            onTapped: onTapped,
            childBuilder:
                (isSelectedV, optionV) => Rbit(
                  width: width,
                  text: optionV,
                  selectedValue: selectedValue,
                  isSelected: isSelectedV,
                ),
          ),
        );
      },
    );
  }
}
