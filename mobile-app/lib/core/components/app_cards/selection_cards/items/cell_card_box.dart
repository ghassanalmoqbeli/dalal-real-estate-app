import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/items/cell_card_img/cell_card_img.dart';
import 'package:flutter/material.dart';

class CellCardBox extends StatelessWidget {
  const CellCardBox({
    super.key,
    required this.imgPath,
    this.sectionName,
    required this.onTap,
    this.color,
    required this.child,
  });

  final String imgPath;
  final String? sectionName;
  final void Function()? onTap;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 192 / 244,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
          decoration: Themer.bard(color, radius: 12),
          child: Column(
            children: [
              CellCardImg(svgPath: imgPath, label: sectionName),
              const Spacer(),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
