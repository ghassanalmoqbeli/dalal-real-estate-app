import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/dropdown_menu/ct_drop_menu.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/filter_form_item.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class CrAdvCtDrop extends StatelessWidget {
  const CrAdvCtDrop({super.key, this.onSelected});
  final Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterFormItem(
      style: FStyles.s16w4,
      title: kCity,
      child: CtDropMenu(
        respFW: Funcs.respInfWp(32, context),
        onSelected: onSelected,
      ),
    );
  }
}
