import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_field_helper.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_field_wrapper.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final Function(String)? onChanged;
  final Function(String countryName, String countryCode)? onCountryChanged;
  final String initialCountryCode;
  final bool validatorEnabled;
  final TextEditingController phoneController;

  const PhoneField({
    super.key,
    this.onChanged,
    this.onCountryChanged,
    this.initialCountryCode = kDefCountryCode,
    this.validatorEnabled = true,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator:
          (value) => PHelper.validatePhone(
            validatorEnabled: validatorEnabled,
            completeNumber: value ?? '',
            controller: phoneController,
            value: value,
          ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PhoneFieldWrapper(
              controller: phoneController,
              enabled: validatorEnabled,
              onChanged: onChanged,
              fieldState: fieldState,
            ),
            PHelper.buildErrorText(fieldState),
          ],
        );
      },
    );
  }
}
