import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:flutter/material.dart';

class OnMapTextFormField extends StatelessWidget {
  const OnMapTextFormField({
    super.key,
    required this.textFwidth,
    required this.onChange,
    required this.gglOnTap,
  });

  final double textFwidth;
  final Function(String p1) onChange;
  final void Function()? gglOnTap;

  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      validator: (value) => null,
      tAln: TextAlign.left,
      tDir: TextDirection.ltr,
      title: kOnMap,
      inputFwidth: textFwidth,
      onChange: onChange,
      deco: Themer.sufTxtInput(
        hint: kOnMapHint,
        child: GestureDetector(
          onTap: gglOnTap,
          child: const SvgIco(
            padding: 8,
            ico: AssetsData.crAdvGglMap,
            ht: 31,
            wth: 23,
          ),
        ),
        hintStyle: FsC.colSt(FStyles.s12w4, kGreyA60),
      ).copyWith(
        errorStyle: const TextStyle(
          height: 0, // Collapse the error text height
          fontSize: 0, // Make it invisible
          // color: Colors.transparent, // Optional: hide color
        ),
      ),
    );
  }
}
