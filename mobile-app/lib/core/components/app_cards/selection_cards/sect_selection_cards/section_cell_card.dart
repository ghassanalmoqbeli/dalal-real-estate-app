import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/items/cell_card_box.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/sect_selection_cards/tail_button/tail_btn.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class SectCellCard extends StatelessWidget {
  const SectCellCard({
    super.key,
    this.advCountSuffix,
    required this.name,
    required this.img,
    this.onTap,
    this.advCount = '150',
  });
  final String name, img, advCount;
  final String? advCountSuffix;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CellCardBox(
      imgPath: img,
      sectionName: name,
      onTap: onTap,
      child: TailTextBtn(
        onTap: () {},
        advCountSuffix: advCountSuffix ?? 'إعلان',
        advCount: advCount,
        svgModel: const SvgModel(AssetsData.leftArrowSvg, 24, 24),
      ),
    );
  }
}
