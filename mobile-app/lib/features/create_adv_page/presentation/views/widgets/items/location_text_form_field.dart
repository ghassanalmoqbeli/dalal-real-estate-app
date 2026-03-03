import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class LocationTextFormField extends StatelessWidget {
  const LocationTextFormField({
    super.key,
    required this.onChange,
    required this.textFwidth,
  });

  final Function(String p1) onChange;
  final double textFwidth;

  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      title: kLocation,
      hint: kLocationHint,
      onChange: onChange,
      inputFwidth: textFwidth,
    );
  }
}
