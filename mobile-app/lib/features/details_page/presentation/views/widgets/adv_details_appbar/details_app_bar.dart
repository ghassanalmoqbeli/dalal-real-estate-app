import 'package:flutter/material.dart';
import 'package:dallal_proj/core/widgets/back_app_bar_btn.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';

class DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DetailsAppBar({super.key, required this.svgIco});
  final Widget svgIco;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 20.0, left: 8.0),
        child: TwoItmRow(
          mXAlign: MainAxisAlignment.spaceBetween,
          leftChild: svgIco,
          rightChild: const BackAppBarBtn(),
        ),
      ),
    );
  }
}
