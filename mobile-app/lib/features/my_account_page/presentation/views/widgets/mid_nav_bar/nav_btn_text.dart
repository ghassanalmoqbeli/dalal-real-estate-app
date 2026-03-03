import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:flutter/material.dart';

class NavBtnText extends StatelessWidget {
  const NavBtnText({super.key, required this.text, required this.isSelected});
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AText(
      txt: text,
      style: isSelected ? FStyles.gNavBtn : FStyles.whNavBtn,
    );
  }
}
