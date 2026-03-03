import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class MoreIcoText extends StatelessWidget {
  const MoreIcoText({super.key, required this.text, required this.img});
  final String text, img;
  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXSize: MainAxisSize.min,
      leftChild: HPItem(rSpc: 10, child: Text(text)),
      rightChild: SvgIco(ico: img, ht: 21.46, wth: 21.185),
    );
  }
}
