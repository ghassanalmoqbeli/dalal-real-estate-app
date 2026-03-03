import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NextBtn extends StatelessWidget {
  const NextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: const Size(100, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      onPressed: () => GoRouter.of(context).push(AppRouter.kPreRegisterPage),
      child: Text(kNext, style: FsC.colStW(FStyles.s24w6)),
    );
  }
}
