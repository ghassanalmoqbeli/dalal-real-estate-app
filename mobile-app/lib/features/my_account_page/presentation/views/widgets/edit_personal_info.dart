import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/edit_ico.dart';
import 'package:flutter/material.dart';

class EditPersonalInfo extends StatelessWidget {
  const EditPersonalInfo({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.end,
      leftChild: EditIco(onTap: onTap),
      rightChild: RText(kPersonalInfo, FStyles.s16w6h175),
    );
  }
}
