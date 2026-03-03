import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rbot/rbot_l_b.dart';
import 'package:dallal_proj/core/widgets/absorb_widget.dart';
import 'package:flutter/material.dart';

class ReportRadioForm extends StatelessWidget {
  final ValueNotifier<String> selectedValueNotifier;
  final List<String> options;
  final Widget Function(bool isEnabled)? childBuilder;
  final void Function()? onChanged;
  const ReportRadioForm({
    super.key,
    required this.selectedValueNotifier,
    required this.options,
    this.childBuilder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedValueNotifier,
      builder: (context, selectedValue, child) {
        final isEnabled = selectedValue == kRptOthers;
        return TwoItmCol(
          mXSize: MainAxisSize.min,
          topChild: VPItem(
            bSpc: 30,
            child: RbotLB(
              selectedValue: selectedValue,
              options: options,
              onTapped: (value) {
                selectedValueNotifier.value = value;
                onChanged?.call();
              },
            ),
          ),
          btmChild: AbsorbWidget(
            onlyIf: !isEnabled,
            child: childBuilder!(isEnabled),
          ),
        );
      },
    );
  }
}
