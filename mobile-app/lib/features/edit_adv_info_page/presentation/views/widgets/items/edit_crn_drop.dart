import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/wid_lists.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class EditCrnDrop extends StatelessWidget {
  const EditCrnDrop({
    super.key,
    required this.initialCurrency,
    required this.crnOnSelected,
  });

  final String initialCurrency;
  final Function(String?)? crnOnSelected;

  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: 3,
      child: HPItem(
        rSpc: 20,
        child: InfComp(
          title: '',
          child: EditCrnDropMenu(
            initialCurrency: initialCurrency,
            isFltr: false,
            onSelected: crnOnSelected,
          ),
        ),
      ),
    );
  }
}

/// Currency dropdown with initial value
class EditCrnDropMenu extends StatelessWidget {
  const EditCrnDropMenu({
    super.key,
    required this.initialCurrency,
    required this.isFltr,
    this.onSelected,
  });

  final String initialCurrency;
  final bool isFltr;
  final Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Directionality(
        textDirection: WidH.trd,
        child: DropdownMenu(
          onSelected: onSelected,
          menuStyle: Themer.menuStyle(context),
          initialSelection:
              initialCurrency.isNotEmpty ? initialCurrency : 'YER',
          textAlign: TextAlign.center,
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
