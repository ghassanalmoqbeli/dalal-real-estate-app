import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/components/app_input_fields/form_validator_helper.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class BTextFormInput extends StatelessWidget {
  const BTextFormInput({
    super.key,
    this.hinText = '',
    this.onChange,
    this.controller,
    this.autoVmode,
    this.validator,
    this.style = const TextStyle(color: kBlack),
    this.decoration,
    this.keyboardType,
    this.mLength,
    this.tAln,
    this.focusNode,
    this.errTxt,
    this.tDir,
    this.readOnly = false,
    this.onTap,
    this.isObs = false,
    this.mxL,
    this.index = 0,
    this.onFieldSubmitted,
    this.onChangeX,
  });
  final TextDirection? tDir;
  final TextAlign? tAln;
  final String? hinText;
  final String? Function(String?)? validator;
  final String? errTxt;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final Function(String, int)? onChangeX;
  final Function()? onTap;
  final AutovalidateMode? autoVmode;
  final TextStyle style;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final int? mLength, mxL;
  final int index;
  final bool readOnly, isObs;
  final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      maxLines: mxL ?? 1,
      obscureText: isObs,
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      validator:
          validator ?? (value) => FVHelper.reqField(value, errMsg: errTxt),
      cursorColor: kPrimColG,
      onChanged: (value) {
        if (onChangeX != null) {
          onChangeX!(value, index);
        } else if (onChange != null) {
          onChange!(value);
        } else {
          (value) {};
        }
      },
      style: style,
      decoration: decoration ?? Themer.custInputDeco(hintText: hinText),
      focusNode: focusNode,
      maxLength: mLength,
      keyboardType: keyboardType,
      autovalidateMode: autoVmode,
      textDirection: tDir ?? WidH.trd,
      textAlign: tAln ?? WidH.tra,
    );
  }
}
