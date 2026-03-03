import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/dynamic_text.dart';
import 'package:flutter/material.dart';

class AdvDetailsTitle extends StatelessWidget {
  const AdvDetailsTitle({super.key, required this.txt});
  final String txt;
  @override
  Widget build(BuildContext context) {
    return DynamicText(
      txt: txt,
      style: FsC.htStyle(FStyles.s16wB, 2),
      txtAlign: TextAlign.center,
      hPadding: 15,
    );
  }
}
