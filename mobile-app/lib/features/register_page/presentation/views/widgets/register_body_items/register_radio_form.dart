import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/constants/str_lists.dart';
import 'package:dallal_proj/core/components/radio_components/h_radio_form.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/components/app_input_fields/phone_field/phone_field.dart';
import 'package:dallal_proj/core/widgets/toggle_absorber.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class RegisterRadioForm extends StatelessWidget {
  const RegisterRadioForm({
    super.key,
    required ValueNotifier<String> selectedOption,
    this.options = CLstr.radBtnOptions,
    this.onChanged,
    required this.phoneController,
  }) : _selectedOption = selectedOption;

  final TextEditingController phoneController;

  final Function(String)? onChanged;
  final ValueNotifier<String> _selectedOption;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return ToggleAbsorber(
      isEnabledNotifier: _selectedOption,
      toggleWid: HRadioForm(
        olModel: OptionsListModel(title: kIsDiffWAppNumber, options: options),
        selectedOpt: _selectedOption,
        mXAlign: MainAxisAlignment.spaceBetween,
      ),
      contentBuilder:
          (isEnabled) => InfComp(
            title: kWhatsAppNumber,
            child: PhoneField(
              phoneController: phoneController,
              validatorEnabled: isEnabled,
              onChanged: onChanged,
            ),
          ),
    );
  }
}
