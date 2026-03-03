import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';

class PersonalInfoHolder extends StatelessWidget {
  const PersonalInfoHolder({
    super.key,
    required this.title,
    required this.info,
  });
  final String title, info;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: WidH.trd,
      child: Container(
        height: 31,
        width: 245,
        decoration: ShapeDecoration(
          color: kWhiteF6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        child: Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '  ', style: FStyles.s12w4),
                  TextSpan(text: title, style: FsC.colStG(FStyles.s12w5)),
                  TextSpan(text: info, style: FStyles.s12w5),
                ],
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
