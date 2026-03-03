import 'package:dallal_proj/core/components/app_input_fields/form_validator_helper.dart';
import 'package:dallal_proj/core/components/app_input_fields/bases/base_pass_input.dart';
import 'package:flutter/material.dart';

class ConfirmPassField extends StatelessWidget {
  final TextEditingController confirmController;
  final TextEditingController originalController;
  final ValueNotifier<bool> visibilityNotifier;
  final Function(String)? onChanged;

  const ConfirmPassField({
    super.key,
    required this.confirmController,
    required this.originalController,
    required this.visibilityNotifier,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PassInputBase(
      pController: confirmController,
      originalController: originalController,
      visibilityNotifier: visibilityNotifier,
      validator:
          (value) => FVHelper.confPassField(value, originalController.text),
      onChanged: onChanged,
    );
  }
}
