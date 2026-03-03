import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/constants/wid_lists.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';

class CrnDropMenu extends StatelessWidget {
  const CrnDropMenu({super.key, this.isFltr = false, this.onSelected});
  final bool isFltr;
  final Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), //all(0.0),
      child: Directionality(
        textDirection: WidH.trd,
        child: DropdownMenu(
          onSelected: onSelected,
          menuStyle: Themer.menuStyle(context),
          initialSelection: kDefCurrency,
          textAlign: TextAlign.center, //WidH.tra,
          textStyle: FsC.colStW(FStyles.s14w6),
          inputDecorationTheme: Themer.menuTheme(
            fillColor: kPrimColG,
            iconColor: kWhite,
          ),
          dropdownMenuEntries: CLwid.cddmList(isFltr: isFltr),
          width: Funcs.respWidth(fract: 0.25, context: context),
        ),
      ),
    );
  }
}
