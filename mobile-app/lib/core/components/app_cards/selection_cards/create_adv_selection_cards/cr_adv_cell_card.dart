import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/items/cell_card_box.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/create_adv_selection_cards/cr_adv_card_title.dart';
import 'package:flutter/material.dart';

class CrAdvCellCard extends StatelessWidget {
  const CrAdvCellCard({
    super.key,
    required this.name,
    required this.img,
    this.onTap,
  });
  final String name, img;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CellCardBox(
      color: kPrimColG,
      imgPath: img,
      onTap: onTap,
      child: CrAdvCardTitle(title: name),
    );
  }
}
