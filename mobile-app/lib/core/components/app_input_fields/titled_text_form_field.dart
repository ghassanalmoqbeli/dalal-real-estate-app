import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_form_input.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:flutter/material.dart';

class TitledTextFormField extends StatelessWidget {
  const TitledTextFormField({
    super.key,
    this.inputFwidth,
    required this.title,
    this.hint = '',
    this.titleStyle,
    this.hintStyle,
    this.spacing = 10,
    this.height = 56,
    this.onChange,
    this.deco,
    this.keyboardType,
    this.mxL,
    this.tAln = TextAlign.right,
    this.tDir = TextDirection.rtl,
    this.mLth,
    this.cXAl,
    this.controller,
    this.focusNode,
    this.inputStyle = const TextStyle(color: kBlack, fontSize: 14),
    this.errTxt = '',
    this.onChangeX,
    this.index = 0,
    this.validator,
  });

  final String title, hint;
  final String? errTxt;
  final TextStyle? titleStyle, hintStyle;
  final TextStyle inputStyle;
  final double? spacing, height, inputFwidth;
  final int? mxL, mLth;
  final int index;
  final Function(String)? onChange;
  final Function(String, int)? onChangeX;
  final InputDecoration? deco;
  final TextInputType? keyboardType;
  final TextAlign tAln;
  final TextDirection tDir;
  final CrossAxisAlignment? cXAl;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return InfComp(
      cXAl: cXAl,
      spacing: spacing,
      title: title,
      titleStyle: titleStyle ?? FStyles.s16w4,
      child: SizedBox(
        height: height,
        width: Funcs.respWidth(fract: inputFwidth ?? 1, context: context),
        child: BTextFormInput(
          validator: validator,
          index: index,
          errTxt: errTxt,
          style: inputStyle,
          controller: controller,
          focusNode: focusNode,
          onChange: onChange,
          onChangeX: onChangeX,
          keyboardType: keyboardType ?? TextInputType.text,
          mxL: mxL ?? 1,
          mLength: mLth,
          tAln: tAln,
          tDir: tDir,
          decoration:
              deco ??
              Themer.numInput(
                hint,
                hintStyle: hintStyle ?? FsC.colSt(FStyles.s12w4, kGreyA60),
              ).copyWith(
                counterText: '',
                errorStyle: const TextStyle(
                  height: 0, // Collapse the error text height
                  fontSize: 0, // Make it invisible
                  color: Colors.transparent, // Optional: hide color
                ),
              ),
        ),
      ),
    );
  }
}
