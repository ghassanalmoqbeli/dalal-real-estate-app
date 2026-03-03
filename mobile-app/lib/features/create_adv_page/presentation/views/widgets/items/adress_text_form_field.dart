import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class AdressTextFormField extends StatelessWidget {
  const AdressTextFormField({
    super.key,
    required this.onChange,
    required this.adrFwidth,
  });

  final Function(String) onChange;
  final double adrFwidth;

  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      title: kAdress,
      hint: kAdressHint,
      onChange: onChange,
      inputFwidth: adrFwidth,
      mxL: 3,
      height: null,
    );
  }
}
