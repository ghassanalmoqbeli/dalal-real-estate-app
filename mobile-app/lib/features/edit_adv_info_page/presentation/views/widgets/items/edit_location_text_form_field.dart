import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class EditLocationTextFormField extends StatefulWidget {
  const EditLocationTextFormField({
    super.key,
    required this.initialValue,
    required this.onChange,
    required this.textFwidth,
  });

  final String initialValue;
  final Function(String) onChange;
  final double textFwidth;

  @override
  State<EditLocationTextFormField> createState() =>
      _EditLocationTextFormFieldState();
}

class _EditLocationTextFormFieldState extends State<EditLocationTextFormField> {
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
      title: kLocation,
      hint: kLocationHint,
      onChange: widget.onChange,
      inputFwidth: widget.textFwidth,
    );
  }
}
