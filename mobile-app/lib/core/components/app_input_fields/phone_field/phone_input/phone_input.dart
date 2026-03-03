import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_input/phone_input_box.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    super.key,
    required this.controller,
    required this.enabled,
    this.onChanged,
    this.onCountryChanged,
    required this.hasError,
  });
  final TextEditingController controller;
  final bool enabled;
  final void Function(PhoneNumber)? onChanged;
  final void Function(Country)? onCountryChanged;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return PhoneInputBox(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
      hasError: hasError,
    );
  }
}
