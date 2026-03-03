import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/more_body_item_holder.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/more_ico_text.dart';
import 'package:dallal_proj/features/more_page/presentation/views/widgets/items/more_tail_btn.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class MoreBodyItem extends StatelessWidget {
  const MoreBodyItem({
    super.key,
    this.onTap,
    required this.text,
    required this.img,
  });
  final void Function()? onTap;
  final String text, img;

  @override
  Widget build(BuildContext context) {
    return MoreBodyItemHolder(
      child: MoreTailBtn(
        onTap: onTap,
        svgModel: const SvgModel(AssetsData.kMoreArrow, 21.46, 21.185),
        textWidget: MoreIcoText(text: text, img: img),
        // icoText,
      ),
    );
  }
}
