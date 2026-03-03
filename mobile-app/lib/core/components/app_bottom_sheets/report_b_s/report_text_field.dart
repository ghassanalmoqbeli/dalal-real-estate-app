import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_form_input.dart';
import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_input.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:flutter/material.dart';

class ReportTextField extends StatelessWidget {
  const ReportTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.title,
    this.hint,
    this.hintStyle,
    this.hPadding,
    this.spacing,
    this.textStyle,
    this.isEnabled,
    this.mxL,
    this.titleStyle,
  });

  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? title, hint;
  final double? hPadding, spacing;
  final TextStyle? textStyle, hintStyle, titleStyle;
  final bool? isEnabled;
  final int? mxL;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return InfComp(
      title: title ?? kMoreDets,
      titleStyle: titleStyle,
      spacing: spacing ?? 15,
      hpadding: hPadding ?? 4,
      txtRightPadding: 2,
      child: SizedBox(
        child: BTextInput(
          controller: controller,
          maxLines: mxL ?? 5,
          textStyle: textStyle,
          isEnabled: isEnabled,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: Themer.txtInput(
            hint: hint ?? kNputAnyMoreDets,
            hintStyle: hintStyle ?? FsC.colStH(FStyles.s12w4),
          ),
        ),
      ),
    );
  }
}

class STextField extends StatelessWidget {
  const STextField({
    super.key,
    required this.onChanged,
    this.onSubmitted,
    this.title,
    this.hint,
    this.hintStyle,
    this.hPadding,
    this.spacing,
    this.textStyle,
    this.isEnabled,
    this.mxL,
  });

  final void Function(String) onChanged;
  final void Function(String)? onSubmitted;
  final String? title, hint;
  final double? hPadding, spacing;
  final TextStyle? textStyle, hintStyle;
  final bool? isEnabled;
  final int? mxL;

  @override
  Widget build(BuildContext context) {
    return InfComp(
      titleStyle: textStyle ?? FStyles.s16w5,
      title: title ?? kMoreDets,
      spacing: spacing ?? 15,
      hpadding: hPadding ?? 4,
      txtRightPadding: 2,
      child: SizedBox(
        child: BTextFormInput(
          mxL: mxL,

          style: textStyle ?? FStyles.s16w5,
          onChange: onChanged,
          onFieldSubmitted: onSubmitted,
          decoration: Themer.numInput(
            hint ?? kNputAnyMoreDets,
            hintStyle: hintStyle ?? FsC.colStH(FStyles.s12w4),
          ),
        ),
      ),
    );
  }
}
