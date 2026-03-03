import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/constants/wid_lists.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class EditCtDropMenu extends StatelessWidget {
  const EditCtDropMenu({
    super.key,
    required this.initialCity,
    this.respFW,
    this.onSelected,
  });

  final String initialCity;
  final double? respFW;
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
          initialSelection: initialCity,
          textAlign: WidH.tra,
          inputDecorationTheme: Themer.menuTheme(),
          dropdownMenuEntries: CLwid.ddmList(),
          width: Funcs.respWidth(fract: respFW ?? 0.880, context: context),
        ),
      ),
    );
  }
}
