import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/dropdown_menu/crn_drop_menu.dart';
import 'package:dallal_proj/core/components/app_input_fields/numeric_field/numeric_field.dart';
import 'package:flutter/material.dart';

class FromToFields extends StatelessWidget {
  const FromToFields({
    super.key,
    this.withCurrency = false,
    this.aspect = 174.4417 / 56,
    this.spacingFract = 0.09,
    this.minPriceController,
    this.maxPriceController,
    this.minAreaController,
    this.maxAreaController,
    this.onCurrencySelected,
    this.onPriceChanged,
    this.onAreaChanged,
  });
  final bool withCurrency;
  final double aspect, spacingFract;
  final TextEditingController? minPriceController;
  final TextEditingController? maxPriceController;
  final TextEditingController? minAreaController;
  final TextEditingController? maxAreaController;
  final ValueChanged<String?>? onCurrencySelected;
  final VoidCallback? onPriceChanged;
  final VoidCallback? onAreaChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (withCurrency) CrnDropMenu(onSelected: onCurrencySelected),
        if (withCurrency) SBx.rWsbx(spacingFract, context),
        NumericField(
          hint: kTo,
          aspect: aspect,
          controller: withCurrency ? maxPriceController : maxAreaController,
          onChanged: withCurrency ? onPriceChanged : onAreaChanged,
        ),
        SBx.rWsbx(spacingFract, context),
        NumericField(
          hint: kFrom,
          aspect: aspect,
          controller: withCurrency ? minPriceController : minAreaController,
          onChanged: withCurrency ? onPriceChanged : onAreaChanged,
        ),
      ],
    );
  }
}
