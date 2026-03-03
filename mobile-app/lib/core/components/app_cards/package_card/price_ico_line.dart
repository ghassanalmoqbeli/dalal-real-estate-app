import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class PriceIcoLine extends StatelessWidget {
  const PriceIcoLine({super.key, required this.type, this.icoSize, this.style});

  final PackageType type;
  final double? icoSize;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return RightIcoLine0(
      text: '$kPrice \$${type.price}',
      icoPath: AssetsData.pckgPrice,
      style: FsC.colSt(style ?? FStyles.s12w5, type.color),
      color: type.color,
      icoHt: icoSize,
      icoWth: icoSize,
    );
  }
}

class RightIcoLine0 extends StatelessWidget {
  const RightIcoLine0({
    super.key,
    required this.text,
    required this.icoPath,
    required this.style,
    this.icoHt,
    this.icoWth,
    required this.color,
  });
  final String text, icoPath;
  final TextStyle style;
  final double? icoHt, icoWth;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TwoItmRow(
      mXAlign: MainAxisAlignment.end,
      leftChild: HPItem(
        rSpc: 5,
        child: Text(
          text,
          style: style,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      rightChild: SvgIco(
        ico: icoPath,
        ht: icoHt ?? 13,
        wth: icoWth ?? 13,
        color: color,
      ),
    );
  }
}
