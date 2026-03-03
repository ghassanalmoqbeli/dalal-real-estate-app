import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/components/app_labels/lbl_helper.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:flutter/material.dart';

class PremiumLabel extends StatelessWidget {
  const PremiumLabel({
    super.key,
    this.width = 46,
    this.height = 19,
    this.fontSize = 10,
  });
  final double width, height, fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      decoration: LblHelper.prmLabel(null),
      child: AText(
        mXAlign: MainAxisAlignment.center,
        txt: 'مميز',
        style: FsC.premiumLabelTextStyle(fontSize),
      ),
    );
  }
}
