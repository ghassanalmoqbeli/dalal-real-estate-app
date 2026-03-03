import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class HDescItem extends StatelessWidget {
  const HDescItem({super.key, required this.tail, required this.head});

  final String tail;
  final String head;

  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      leftChild: RText(tail, FStyles.s14W4),
      rightChild: RText(head, FStyles.s14w6),
    );
  }
}
