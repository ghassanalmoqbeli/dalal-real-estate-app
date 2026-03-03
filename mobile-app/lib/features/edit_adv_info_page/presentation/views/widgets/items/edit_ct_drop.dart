import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/filter_form_item.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_ct_drop_menu.dart';
import 'package:flutter/material.dart';

class EditCtDrop extends StatelessWidget {
  const EditCtDrop({super.key, required this.initialCity, this.onSelected});

  final String initialCity;
  final Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterFormItem(
      style: FStyles.s16w4,
      title: kCity,
      child: EditCtDropMenu(
        initialCity: initialCity,
        respFW: Funcs.respInfWp(32, context),
        onSelected: onSelected,
      ),
    );
  }
}
