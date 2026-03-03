import 'package:dallal_proj/core/components/app_input_fields/titled_text_form_field.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_crn_drop.dart';
import 'package:flutter/material.dart';

class EditPriceTFF extends StatefulWidget {
  const EditPriceTFF({
    super.key,
    required this.initialPrice,
    required this.initialCurrency,
    required this.crnOnSelected,
    required this.priceOnChanged,
  });

  final String initialPrice;
  final String initialCurrency;
  final Function(String?)? crnOnSelected;
  final Function(String)? priceOnChanged;

  @override
  State<EditPriceTFF> createState() => _EditPriceTFFState();
}

class _EditPriceTFFState extends State<EditPriceTFF> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialPrice);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        EditCrnDrop(
          initialCurrency: widget.initialCurrency,
          crnOnSelected: widget.crnOnSelected,
        ),
        TitledTextFormField(
          controller: _controller,
          title: kPrice,
          inputFwidth: 0.5,
          onChange: widget.priceOnChanged,
          keyboardType: TextInputType.number,
          tAln: TextAlign.center,
          tDir: TextDirection.ltr,
        ),
      ],
    );
  }
}
