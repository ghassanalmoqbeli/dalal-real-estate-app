import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.text,
    required this.onTap,
    this.txtAlign,
    this.textcolor = kPrimColG,
  });
  final String text;
  final Color textcolor;
  final void Function()? onTap;
  final TextAlign? txtAlign;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AText(
        txt: text,
        style: FsC.colSt(FStyles.s12w5, textcolor),
        mXAlign: MainAxisAlignment.end,
      ),
    );
  }
}
