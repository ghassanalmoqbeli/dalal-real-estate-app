import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/text_widgets/v_p_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rbit/rbit_l_b.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class VTitleRbit extends StatelessWidget {
  const VTitleRbit({
    super.key,
    required this.selectedOpt,
    required this.oLModel,
    this.width,
    this.onChanged,
  });
  final ValueNotifier<String> selectedOpt;
  final OptionsListModel oLModel;
  final double? width;
  final VoidCallback? onChanged;
  @override
  Widget build(BuildContext context) {
    return TwoItmCol(
      cXAlign: CrossAxisAlignment.end,
      topChild: VPText(txt: oLModel.title, style: FStyles.s14w6, bSpc: 20),
      btmChild: VPItem(
        bSpc: 10,
        child: RbitLB(
          selectedValueNotifier: selectedOpt,
          // onTapped: (value) => selectedOpt.value = value,
          onTapped: (value) {
            selectedOpt.value = value;
            onChanged?.call(); // Call onChanged
          },
          width: width ?? 4,
          options: oLModel.options,
        ),
      ),
    );
  }
}
