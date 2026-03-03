import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = kPrimColR35,
  Duration duration = const Duration(seconds: 5),
  bool showClose = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(9)),
      ),
      showCloseIcon: true, //showClose,
      elevation: 3,

      // margin: const EdgeInsets.all(8),
      backgroundColor: backgroundColor,
      content: Text(message),
      duration: duration,
    ),
  );
}
