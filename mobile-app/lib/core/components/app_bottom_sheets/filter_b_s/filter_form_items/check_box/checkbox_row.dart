import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/check_box/mc_checkbox.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class CheckboxRow extends StatelessWidget {
  const CheckboxRow({
    super.key,
    required this.oLModel,
    this.onSelectionChanged,
    this.initialSelected,
  });
  final OptionsListModel oLModel;
  final ValueChanged<List<String>>? onSelectionChanged;
  final List<String>? initialSelected; // Initial selected API values
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Funcs.respWidth(fract: 0.9, context: context),
      child: TwoItmRow(
        leftChild: McCheckbox(
          options: oLModel.options,
          initialSelected: initialSelected,
          onSelectionChanged: onSelectionChanged,
          borderColor: kBlack,
          activeColor: kPrimColG,
          checkColor: kWhite,
          checkboxScale: 0.7,
        ),
        rightChild: RText(oLModel.title, FStyles.s14w6, txtAlign: WidH.tra),
      ),
    );
  }
}
