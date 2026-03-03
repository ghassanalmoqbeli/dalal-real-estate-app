import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/prop_sect_text_form_field.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class PropSectFieldBox extends StatelessWidget {
  const PropSectFieldBox({
    super.key,
    required this.onChange,
    required this.tfModel,
  });
  final Function(String, int) onChange;
  final TFModel tfModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(tfModel.codeLength, (index) {
        return PropSectTextFormField(
          onChange: onChange,
          title: tfModel.titles[index],
          controller: tfModel.controllers[index],
          width: tfModel.widthF,
          index: index,
        );
      }),
    );
  }
}
