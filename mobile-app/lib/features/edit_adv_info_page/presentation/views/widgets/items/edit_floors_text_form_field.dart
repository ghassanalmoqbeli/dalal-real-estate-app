import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:flutter/material.dart';

class EditFloorsTFF extends StatefulWidget {
  const EditFloorsTFF({
    super.key,
    required this.initialValue,
    required this.onChange,
  });

  final String initialValue;
  final Function(String) onChange;

  @override
  State<EditFloorsTFF> createState() => _EditFloorsTFFState();
}

class _EditFloorsTFFState extends State<EditFloorsTFF> {
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
      title: kFloorsCount,
      onChange: widget.onChange,
      keyboardType: TextInputType.number,
      inputFwidth: 0.6,
      mLth: 3,
      tAln: TextAlign.center,
      tDir: TextDirection.ltr,
    );
  }
}
