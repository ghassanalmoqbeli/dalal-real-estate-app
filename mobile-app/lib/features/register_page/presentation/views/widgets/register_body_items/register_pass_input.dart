import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/components/app_input_fields/pass_fields/pass_field.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class RegisterPassInput extends StatelessWidget {
  const RegisterPassInput({
    super.key,
    this.onChanged,
    required this.pController,
    required this.visibilityNotifier,
  });
  final Function(String)? onChanged;
  final TextEditingController pController;
  final ValueNotifier<bool> visibilityNotifier;
  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: 20,
      bSpc: 40,
      child: InfComp(
        title: kPassword,
        child: PassField(
          controller: pController,
          visibilityNotifier: visibilityNotifier,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
