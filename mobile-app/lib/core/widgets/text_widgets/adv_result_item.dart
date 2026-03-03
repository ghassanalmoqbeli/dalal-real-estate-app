import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/sect_selection_cards/tail_button/tail_btn_txt.dart';
import 'package:flutter/material.dart';

class AdvResultsItem extends StatelessWidget {
  const AdvResultsItem({super.key, required this.advCount});

  final String advCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 2),
        TailBtnText(txt: kAdv, style: FsC.colStB(FStyles.s12w4)),
        const Spacer(flex: 1),
        TailBtnText(txt: advCount, style: FsC.colStB(FStyles.s12w4)),
        const Spacer(flex: 30),
      ],
    );
  }
}
