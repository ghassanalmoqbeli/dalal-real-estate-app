import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class EditAdressTextFormField extends StatefulWidget {
  const EditAdressTextFormField({
    super.key,
    required this.initialValue,
    required this.onChange,
    required this.adrFwidth,
  });

  final String initialValue;
  final Function(String) onChange;
  final double adrFwidth;

  @override
  State<EditAdressTextFormField> createState() =>
      _EditAdressTextFormFieldState();
}

class _EditAdressTextFormFieldState extends State<EditAdressTextFormField> {
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
      title: kAdress,
      hint: kAdressHint,
      onChange: widget.onChange,
      inputFwidth: widget.adrFwidth,
      mxL: 3,
      height: null,
    );
  }
}
