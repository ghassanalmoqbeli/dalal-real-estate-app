import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_location_text_form_field.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_on_map_text_form_field.dart';
import 'package:flutter/material.dart';

class EditLocMapTextFormFields extends StatelessWidget {
  const EditLocMapTextFormFields({
    super.key,
    required this.initialLocation,
    required this.initialMapLink,
    required this.textFwidth,
    required this.locOnChange,
    required this.mapOnChange,
    required this.gglOnTap,
  });

  final String initialLocation;
  final String initialMapLink;
  final double textFwidth;
  final Function(String) locOnChange, mapOnChange;
  final void Function()? gglOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EditOnMapTextFormField(
          initialValue: initialMapLink,
          textFwidth: textFwidth,
          onChange: mapOnChange,
          gglOnTap: gglOnTap,
        ),
        EditLocationTextFormField(
          initialValue: initialLocation,
          onChange: locOnChange,
          textFwidth: textFwidth,
        ),
      ],
    );
  }
}
