import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_field.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class RegisterPhoneInput extends StatelessWidget {
  const RegisterPhoneInput({
    super.key,
    this.onChanged,
    required this.phoneController,
  });
  final Function(String)? onChanged;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: 23,
      bSpc: 23,
      child: InfComp(
        title: kPhoneNumber,
        child: PhoneField(
          onChanged: onChanged,
          phoneController: phoneController,
        ),
      ),
    );
  }
}
