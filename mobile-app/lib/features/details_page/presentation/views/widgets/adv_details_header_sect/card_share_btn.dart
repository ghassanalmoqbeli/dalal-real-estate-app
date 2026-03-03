import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/app_btns/tcon_btn.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_colors.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:flutter/material.dart';

class CardShareBtn extends StatelessWidget {
  const CardShareBtn({
    super.key,
    required this.shareBtnSize,
    this.radius,
    this.onTap,
    this.mXAlign,
  });

  final XBSize shareBtnSize;
  final double? radius;
  final void Function()? onTap;
  final MainAxisAlignment? mXAlign;

  @override
  Widget build(BuildContext context) {
    return TconBtn(
      onTap: onTap,
      btnCols: const XBColors(fill: kPrimColG),
      btnSize: shareBtnSize,
      radius: radius,
      leftChild: Text(kShare, style: FsC.colStW(FStyles.s10wB)),
      rightChild: const SvgIco(ico: AssetsData.shareSvg, ht: 18, wth: 18),
    );
  }
}
