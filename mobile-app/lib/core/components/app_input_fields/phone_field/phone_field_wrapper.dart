import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_input/phone_input.dart';
import 'package:flutter/material.dart';

class PhoneFieldWrapper extends StatefulWidget {
  final TextEditingController controller;
  final bool enabled;
  final Function(String)? onChanged;
  final Function(String countryName, String countryCode)? onCountryChanged;
  final FormFieldState<String> fieldState;

  const PhoneFieldWrapper({
    super.key,
    required this.controller,
    required this.enabled,
    this.onChanged,
    this.onCountryChanged,
    required this.fieldState,
  });

  @override
  State<PhoneFieldWrapper> createState() => _PhoneFieldWrapperState();
}

class _PhoneFieldWrapperState extends State<PhoneFieldWrapper> {
  late String _completeNumber;

  @override
  Widget build(BuildContext context) {
    return PhoneInput(
      controller: widget.controller,
      enabled: widget.enabled,
      hasError: widget.fieldState.hasError,
      onChanged: (phone) {
        _completeNumber = phone.number;
        widget.fieldState.didChange(_completeNumber);
        widget.onChanged?.call(_completeNumber);
      },
      onCountryChanged: (country) {
        widget.onCountryChanged?.call(country.name, country.code);
      },
    );
  }
}
