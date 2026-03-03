import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class PropSectTextFormField extends StatelessWidget {
  const PropSectTextFormField({
    super.key,
    required this.onChange,
    required this.title,
    required this.width,
    this.index = 0,
    this.controller,
    this.fNode,
  });

  final Function(String, int) onChange;
  final String title;
  final double width;
  final int index;
  final TextEditingController? controller;
  final FocusNode? fNode;
  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      index: index,
      title: title,
      controller: controller,
      focusNode: fNode,
      cXAl: CrossAxisAlignment.center,
      titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      onChangeX: onChange,
      keyboardType: TextInputType.number,
      inputFwidth: width,
      tAln: TextAlign.center,
      tDir: TextDirection.ltr,
      mLth: 2,
      deco: Themer.numInput('').copyWith(
        counterText: '',
        errorStyle: const TextStyle(
          height: 0, // Collapse the error text height
          fontSize: 0, // Make it invisible
          // color: Colors.transparent, // Optional: hide color
        ),
      ),
    );
  }
}
