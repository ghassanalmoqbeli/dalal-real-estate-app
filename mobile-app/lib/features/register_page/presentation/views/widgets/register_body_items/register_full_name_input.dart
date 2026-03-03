import 'package:dallal_proj/core/components/app_input_fields/bases/base_text_form_input.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class RegisterFullNameInput extends StatelessWidget {
  const RegisterFullNameInput({
    super.key,
    this.controller,
    required this.onChanged,
    required this.tDir,
    required this.tAln,
  });
  final Function(String) onChanged;
  final TextDirection tDir;
  final TextAlign tAln;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: 40,
      bSpc: 23,
      child: InfComp(
        title: kName,
        child: BTextFormInput(
          controller: controller,
          autoVmode: AutovalidateMode.onUserInteraction,
          hinText: kInputUrFullName,
          onChange: onChanged,
          tAln: tAln,
          tDir: tDir,
          // keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
