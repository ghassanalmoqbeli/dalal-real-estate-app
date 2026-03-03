import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:flutter/material.dart';

class FilterBtnHolder extends StatelessWidget {
  const FilterBtnHolder({super.key, required this.isMinSize});

  final bool isMinSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: isMinSize ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (!isMinSize) const Spacer(flex: 13),
        Text(
          kFilter,
          style: FsC.colStW(isMinSize ? FStyles.s12w5 : FStyles.s16w5),
        ),
        if (!isMinSize) const Spacer(flex: 1) else const SizedBox(width: 5),
        const SvgIco(ico: AssetsData.filterSvg, ht: 24, wth: 24),
      ],
    );
  }
}
