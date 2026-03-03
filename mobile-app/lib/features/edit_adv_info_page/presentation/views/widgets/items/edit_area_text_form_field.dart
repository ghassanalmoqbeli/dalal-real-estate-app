import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class EditAreaTextFormField extends StatefulWidget {
  const EditAreaTextFormField({
    super.key,
    required this.initialValue,
    required this.onChange,
  });

  final String initialValue;
  final Function(String) onChange;

  @override
  State<EditAreaTextFormField> createState() => _EditAreaTextFormFieldState();
}

class _EditAreaTextFormFieldState extends State<EditAreaTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TitledTextFormField(
      controller: _controller,
      title: kArea,
      hint: kAreaHint,
      onChange: widget.onChange,
      inputFwidth: 0.6,
      keyboardType: TextInputType.number,
      tAln: TextAlign.center,
      tDir: TextDirection.ltr,
    );
  }
}
