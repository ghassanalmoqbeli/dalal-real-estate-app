import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_form_input.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class NumericInput extends StatelessWidget {
  final int index;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String, int)? onChangedX;
  final Function(String)? onChanged;
  final InputDecoration? deco;
  final String? errTxt;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final int? mLength;
  final int? mxL;
  final TextAlign? tAln;
  final TextDirection? tDir;

  const NumericInput({
    super.key,
    this.index = 0,
    this.controller,
    this.focusNode,
    this.onChangedX,
    this.onChanged,
    this.style,
    this.deco,
    this.mLength,
    this.errTxt,
    this.keyboardType,
    this.mxL = 1,
    this.tAln,
    this.tDir,
  });

  @override
  Widget build(BuildContext context) {
    return BTextFormInput(
      onChange: (value) {
        if (onChangedX != null) {
          onChangedX!(value, index);
        } else if (onChanged != null) {
          onChanged!(value);
        } else {
          (value) {};
        }
      },
      mxL: mxL,
      mLength: mLength,
      controller: controller,
      focusNode: focusNode,
      decoration: deco,
      style: style ?? const TextStyle(color: kBlack),
      errTxt: errTxt ?? kErrVfCodeField,
      tAln: tAln ?? TextAlign.center,
      tDir: tDir ?? TextDirection.ltr,
      keyboardType: keyboardType ?? TextInputType.number,
    );
  }
}
