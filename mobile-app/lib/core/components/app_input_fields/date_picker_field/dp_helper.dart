import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class DpHelper {
  static Future<DateTime?> showDP(
    BuildContext context,
    DateTime initDate,
    DateTime firstDate,
    DateTime lastDate,
  ) {
    return showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: firstDate,
      lastDate: lastDate,

      builder: (BuildContext context, Widget? child) {
        return dpTheme(context, child!);
      },
    );
  }

  static Theme dpTheme(BuildContext context, Widget child) => Theme(
    data: Theme.of(context).copyWith(
      datePickerTheme: const DatePickerThemeData(
        headerBackgroundColor: kPrimColG,
        headerForegroundColor: kWhite,
      ),
      colorScheme: const ColorScheme.light(
        outlineVariant: kPrimColG,
        primary: kPrimColG,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: kPrimColG),
      ),
    ),
    child: child,
  );

  static InputDecoration dpInputDeco() {
    final base = Themer.custInputDeco(hintText: kDtPickerHint);
    return base.copyWith(prefixIcon: const Icon(Icons.edit_calendar));
  }
}
