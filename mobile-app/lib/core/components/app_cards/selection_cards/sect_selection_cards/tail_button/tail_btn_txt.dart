import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:flutter/material.dart';

class TailBtnText extends StatelessWidget {
  const TailBtnText({super.key, required this.txt, this.style, this.color});

  final String txt;
  final TextStyle? style;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return RText(
      txt,
      style ?? FsC.colStH60(FStyles.s10w4).copyWith(height: 2.60),
      txtAlign: TextAlign.right,
    );
  }
}
