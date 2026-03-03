import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class AreaTextFormField extends StatelessWidget {
  const AreaTextFormField({super.key, required this.onChange});

  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      title: kArea,
      hint: kAreaHint,
      onChange: onChange,
      inputFwidth: 0.6,
      keyboardType: TextInputType.number,
      tAln: TextAlign.center,
      tDir: TextDirection.ltr,
    );
  }
}
