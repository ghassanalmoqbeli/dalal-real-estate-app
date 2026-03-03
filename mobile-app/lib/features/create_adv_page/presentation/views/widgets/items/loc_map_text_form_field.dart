import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/location_text_form_field.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/on_map_text_form_field.dart';
import 'package:flutter/material.dart';

class LocMapTextFormFields extends StatelessWidget {
  const LocMapTextFormFields({
    super.key,
    required this.textFwidth,
    required this.locOnChange,
    required this.mapOnChange,
    required this.gglOnTap,
  });

  final double textFwidth;
  final Function(String) locOnChange, mapOnChange;
  final void Function()? gglOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OnMapTextFormField(
          textFwidth: textFwidth,
          onChange: mapOnChange,
          gglOnTap: gglOnTap,
        ),
        LocationTextFormField(onChange: locOnChange, textFwidth: textFwidth),
      ],
    );
  }
}
