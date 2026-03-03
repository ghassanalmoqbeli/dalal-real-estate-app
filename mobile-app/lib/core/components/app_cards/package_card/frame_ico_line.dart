import 'package:dallal_proj/core/components/app_cards/package_card/price_ico_line.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';

class FrameIcoLine extends StatelessWidget {
  const FrameIcoLine({super.key, required this.type, this.icoSize, this.style});

  final PackageType type;
  final double? icoSize;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return RightIcoLine0(
      text: '$kFrame ${type.frame} $kDay',
      icoPath: AssetsData.pckgFrame,
      style: FsC.colSt(style ?? FStyles.s12w5, type.color),
      color: type.color,
      icoHt: icoSize,
      icoWth: icoSize,
    );
  }
}
