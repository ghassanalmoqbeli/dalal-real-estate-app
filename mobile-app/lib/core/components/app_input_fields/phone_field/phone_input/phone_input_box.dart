import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_field_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneInputBox extends StatelessWidget {
  const PhoneInputBox({
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
    return IntlPhoneField(
      controller: controller,
      enabled: enabled,
      decoration: PHelper.deco(hasError),
      languageCode: kDefPhoneInpLang,
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
      invalidNumberMessage: '',
      pickerDialogStyle: PHelper.style(),
      initialCountryCode: kDefCountryCode,
      flagsButtonMargin: const EdgeInsets.only(right: 8),
      flagsButtonPadding: const EdgeInsets.only(left: 8),
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.left,
      dropdownIconPosition: IconPosition.trailing,
      dropdownDecoration: PHelper.ddd(),
    );
  }
}
