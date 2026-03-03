import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/components/app_btns/white_btn.dart';
import 'package:flutter/material.dart';

class BottomSheetBtns extends StatelessWidget {
  const BottomSheetBtns({
    super.key,
    this.onTapR,
    this.onTapL,
    required this.rBtnTxt,
    required this.lBtnTxt,
    this.rBtnCol,
    this.btnSize,
  });
  final void Function()? onTapR, onTapL;
  final String rBtnTxt, lBtnTxt;
  final Color? rBtnCol;
  final XBSize? btnSize;

  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.spaceAround,
      leftChild: WhiteBtn(
        txt: lBtnTxt,
        style: FStyles.s16wB,
        size: btnSize ?? const XBSize(width: 155, height: 56),
        onPressed: onTapL,
      ),
      rightChild: ColBtn(
        deco: Themer.bard(rBtnCol ?? kPrimColR2A),
        txt: rBtnTxt,
        style: FsC.colStW(FStyles.s16wB),
        size: btnSize ?? const XBSize(width: 155, height: 56),
        onPressed: onTapR,
      ),
    );
  }
}
