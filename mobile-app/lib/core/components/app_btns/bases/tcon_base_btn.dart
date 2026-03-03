import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/components/app_btns/btn_flex_box.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';

abstract class TconBaseBtn extends StatelessWidget {
  const TconBaseBtn({super.key});

  Widget buildLeft(BuildContext context);
  Widget buildRight(BuildContext context);
  XBSize getSize(BuildContext context);
  XBColors getColors(BuildContext context);
  void Function()? getTap();
  double? getRadius(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BtnFlexBox(
      deco: Themer.bard(getColors(context).fill, radius: getRadius(context)),
      btnSize: getSize(context),
      radius: getRadius(context),
      onTap: getTap(),
      btnCols: getColors(context),
      child: TwoItmRow(
        leftChild: buildLeft(context),
        rightChild: buildRight(context),
        mXAlign: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
