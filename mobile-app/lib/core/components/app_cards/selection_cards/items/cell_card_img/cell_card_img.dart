import 'package:dallal_proj/core/components/app_cards/selection_cards/items/cell_card_img/cell_card_img_form.dart';
import 'package:flutter/material.dart';

class CellCardImg extends StatelessWidget {
  const CellCardImg({
    super.key,
    required this.svgPath,
    this.aspectRatio,
    this.label,
  });
  final String svgPath;
  final double? aspectRatio;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return CellCardImgForm(
      aspectRatio: aspectRatio,
      svgPath: svgPath,
      label: label,
    );
  }
}
