import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/radio_components/radio_btns/rbit/h_title_rbit.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class HRadioForm extends StatelessWidget {
  const HRadioForm({
    super.key,
    required this.selectedOpt,
    required this.olModel,
    this.mXAlign,
    this.titleStyle,
    this.onTapped,
    this.onChanged,
  });
  final ValueNotifier<String> selectedOpt;
  final OptionsListModel olModel;
  final MainAxisAlignment? mXAlign;
  final TextStyle? titleStyle;
  final Function(String)? onTapped;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return HTitleRbit(
      onTapped: (value) {
        selectedOpt.value = value;
        onChanged?.call(); // Call onChanged
      }, //onTapped,
      selectedOpt: selectedOpt,
      olModel: olModel,
      titleStyle: titleStyle ?? FStyles.s14W5,
      titleAlign: WidH.tra,
      mXAlign: mXAlign ?? MainAxisAlignment.end,
      rItmSpc: 20,
    );
  }
}
