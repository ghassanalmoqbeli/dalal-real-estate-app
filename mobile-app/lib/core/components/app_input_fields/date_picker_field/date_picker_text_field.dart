import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:flutter/material.dart';
import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_form_input.dart';
import 'package:dallal_proj/core/components/app_input_fields/date_picker_field/dp_helper.dart';
import 'package:dallal_proj/core/components/app_input_fields/form_validator_helper.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;
  final void Function(DateTime)? onDateSelected;

  DatePickerTextField({
    super.key,
    required this.controller,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,

    this.onDateSelected,
  }) : firstDate = firstDate ?? DateTime(2000),
       lastDate = lastDate ?? DateTime(2100),
       initialDate = initialDate ?? DateTime.now();

  @override
  State<StatefulWidget> createState() {
    return _DatePickerTextFieldState();
  }
}

@override
State<DatePickerTextField> createState() => _DatePickerTextFieldState();

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  Future<void> _pickDate() async {
    FocusScope.of(context).requestFocus(FocusNode()); // Prevent keyboard

    final DateTime? picked = await DpHelper.showDP(
      context,
      widget.initialDate,
      widget.firstDate,
      widget.lastDate,
    );

    if (picked != null) {
      widget.controller.text = picked.toLocal().toString().split(' ')[0];
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BTextFormInput(
      validator: (value) => FVHelper.reqField(value),
      onChange: (value) {},
      tAln: WidH.tra,
      controller: widget.controller,
      decoration: DpHelper.dpInputDeco(),
      readOnly: true,
      onTap: _pickDate,
    );
  }
}
