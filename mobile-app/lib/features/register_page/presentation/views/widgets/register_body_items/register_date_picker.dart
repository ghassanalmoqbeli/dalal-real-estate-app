import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/components/app_input_fields/date_picker_field/date_picker_text_field.dart';
import 'package:flutter/material.dart';

class RegisterDatePicker extends StatelessWidget {
  const RegisterDatePicker({
    super.key,
    required TextEditingController dateController,
    this.onDateSelected,
  }) : _dateController = dateController;

  final TextEditingController _dateController;
  final void Function(DateTime)? onDateSelected;
  @override
  Widget build(BuildContext context) {
    return InfComp(
      title: kBirthDate,
      child: DatePickerTextField(
        controller: _dateController,
        onDateSelected: onDateSelected,
      ),
    );
  }
}
