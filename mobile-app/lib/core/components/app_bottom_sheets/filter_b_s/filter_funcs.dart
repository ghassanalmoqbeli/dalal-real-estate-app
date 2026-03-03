import 'package:flutter/material.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';

class Fltr {
  static void callBottomSheet(BuildContext context, {required Widget child}) {
    showModalBottomSheet(
      useSafeArea: false,
      backgroundColor: kWhite,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      context: Navigator.of(context, rootNavigator: true).context, //context,
      builder: (context) => child,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  static BoxDecoration btnDeco() =>
      BoxDecoration(color: kPrimColG, borderRadius: BorderRadius.circular(8));

  static double btnWidth(bool isMinSize, BuildContext context) {
    return isMinSize
        ? Funcs.respWidth(fract: 0.17, context: context)
        : Funcs.respWidth(fract: 0.9, context: context);
  }

  static Widget filterTitle(String title) {
    return AText(txt: title, style: FStyles.s18wB);
  }

  static DropdownMenuEntry<String> ddmNtry(
    String v,
    String l, {
    AlignmentGeometry? textAlign,
  }) => DropdownMenuEntry(
    value: v,
    label: l,
    labelWidget: Align(
      alignment: textAlign ?? Alignment.centerRight,
      child: Text(l),
    ),
  );
}
