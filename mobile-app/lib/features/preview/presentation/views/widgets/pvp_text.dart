import 'package:dallal_proj/core/constants/test_app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';

class PvpText extends StatelessWidget {
  const PvpText({super.key});

  @override
  Widget build(BuildContext context) {
    return RText(
      kTestText,
      FsC.colStW(FStyles.s16w6h175),
      txtAlign: TextAlign.right,
    );
  }
}
