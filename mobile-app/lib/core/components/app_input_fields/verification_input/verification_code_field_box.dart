import 'package:dallal_proj/core/components/app_input_fields/numeric_input.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class VrfCodeFieldBox extends StatelessWidget {
  const VrfCodeFieldBox({
    super.key,
    required this.codeLength,
    required this.onChange,
    required this.controllers,
    required this.focusNodes,
  });
  final int codeLength;
  final Function(String, int) onChange;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(codeLength, (index) {
        return SizedBox(
          width: 50,
          child: NumericInput(
            onChangedX: onChange,
            index: index,
            controller: controllers[index],
            focusNode: focusNodes[index],
            errTxt: kErrVfCodeField,
            mLength: 1,
            style: FStyles.s24w6,
            deco: Themer.verifiCodeInput(),
          ),
        );
      }),
    );
  }
}
