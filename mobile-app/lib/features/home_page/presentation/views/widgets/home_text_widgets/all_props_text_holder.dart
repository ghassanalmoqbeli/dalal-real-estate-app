import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';

class AllPropsTextHolder extends StatelessWidget {
  const AllPropsTextHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: Funcs.respWidth(fract: 0.0545, context: context),
        bottom: Funcs.respHieght(fract: 0.0177, context: context),
      ),
      child: Text(kAllProps, style: FsC.htStyle(FStyles.s18w6, 1.3)),
    );
  }
}
