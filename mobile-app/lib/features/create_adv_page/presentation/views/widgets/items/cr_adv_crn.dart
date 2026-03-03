import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_form_items/dropdown_menu/crn_drop_menu.dart';
import 'package:dallal_proj/core/widgets/inf_comp.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class CrAdvCrn extends StatelessWidget {
  const CrAdvCrn({super.key, required this.crnOnSelected});

  final Function(String? p1)? crnOnSelected;

  @override
  Widget build(BuildContext context) {
    return VPItem(
      tSpc: 3,
      child: HPItem(
        rSpc: 20,
        child: InfComp(
          title: '',
          child: CrnDropMenu(isFltr: false, onSelected: crnOnSelected),
        ),
      ),
    );
  }
}
