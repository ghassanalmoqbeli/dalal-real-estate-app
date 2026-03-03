// ignore_for_file: file_names

import 'package:dallal_proj/core/components/app_input_fields/bases/base_pass_input.dart';
import 'package:dallal_proj/core/components/app_input_fields/form_validator_helper.dart';
import 'package:flutter/material.dart';

class PassField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextEditingController controller;
  final ValueNotifier<bool> visibilityNotifier;
  const PassField({
    super.key,
    this.onChanged,
    required this.controller,
    required this.visibilityNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return PassInputBase(
      validator: (value) => FVHelper.reqPassField(value),
      pController: controller,
      originalController: null,
      onChanged: onChanged,
      visibilityNotifier: visibilityNotifier,
    );
  }
}
