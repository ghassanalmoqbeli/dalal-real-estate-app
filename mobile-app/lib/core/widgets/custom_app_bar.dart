import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/back_app_bar_btn.dart';
import 'package:dallal_proj/core/widgets/text_widgets/r_text.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title = ' ', this.showBackButton = true});
  final String title;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 20.0, left: 28.0),
        child: TwoItmRow(
          mXAlign:
              showBackButton
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
          leftChild: RText(title, FStyles.s25w6),
          rightChild:
              showBackButton ? const BackAppBarBtn() : const SizedBox(width: 0),
        ),
      ),
    );
  }
}
