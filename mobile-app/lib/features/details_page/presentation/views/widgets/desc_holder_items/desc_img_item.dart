import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/desc_map_img.dart';
import 'package:flutter/material.dart';

class DescImgItem extends StatelessWidget {
  const DescImgItem({super.key, required this.head, required this.link});
  final String head;
  final String? link;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: TwoItmRow(
        leftChild: const DeskMapImg(),
        rightChild: RText(head, FStyles.s14w6),
      ),
    );
  }
}
