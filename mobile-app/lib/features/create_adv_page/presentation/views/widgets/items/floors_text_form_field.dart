import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class FloorsTFF extends StatelessWidget {
  const FloorsTFF({super.key, required this.onChange});

  final Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      title: kFloorsCount,
      onChange: onChange,
      keyboardType: TextInputType.number,
      inputFwidth: 0.6,
      mLth: 3,
      tAln: TextAlign.center,
      tDir: TextDirection.ltr,
    );
  }
}
