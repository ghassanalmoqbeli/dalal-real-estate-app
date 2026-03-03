import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/cr_adv_crn.dart';
import 'package:flutter/material.dart';

class PriceTFF extends StatelessWidget {
  const PriceTFF({
    super.key,
    required this.crnOnSelected,
    required this.priceOnChanged,
  });

  final Function(String?)? crnOnSelected;
  final Function(String)? priceOnChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CrAdvCrn(crnOnSelected: crnOnSelected),
        TitledTextFormField(
          title: kPrice,
          inputFwidth: 0.5,
          onChange: priceOnChanged,
          keyboardType: TextInputType.number,
          tAln: TextAlign.center,
          tDir: TextDirection.ltr,
        ),
      ],
    );
  }
}
