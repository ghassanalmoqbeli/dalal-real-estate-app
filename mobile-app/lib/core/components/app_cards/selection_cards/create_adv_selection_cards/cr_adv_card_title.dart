import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:flutter/material.dart';

class CrAdvCardTitle extends StatelessWidget {
  const CrAdvCardTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AText(
      txt: title,
      mXAlign: MainAxisAlignment.center,
      style: FsC.colSt(FStyles.s16w6h175, kWhite),
    );
  }
}
