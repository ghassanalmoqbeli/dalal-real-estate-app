import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:dallal_proj/core/widgets/absorb_widget.dart';
import 'package:flutter/material.dart';

class ToggleAbsorber extends StatelessWidget {
  const ToggleAbsorber({
    super.key,
    required this.toggleWid,
    required this.contentBuilder,
    required this.isEnabledNotifier,
  });

  final Widget toggleWid;
  final Widget Function(bool isEnabled) contentBuilder;
  final ValueNotifier<String> isEnabledNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: isEnabledNotifier,
      builder: (context, isEnabled, _) {
        final enabled = isEnabledNotifier.value == kYes;
        return TwoItmCol(
          mXSize: MainAxisSize.min,
          topChild: VPItem(bSpc: 16, child: toggleWid),
          btmChild: AbsorbWidget(
            onlyIf: !enabled,
            child: contentBuilder(enabled),
          ),
        );
      },
    );
  }
}
