import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';

class NamedLogo extends StatelessWidget {
  const NamedLogo({super.key, this.isBlack = false});
  final bool isBlack;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              isBlack ? AssetsData.bLogo : AssetsData.wLogo,
              width: 236,
              height: 236,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Text(
              kAppName,
              style: FsC.colSt(FStyles.s50W6, isBlack ? kBlack : kWhite),
            ),
          ),
        ],
      ),
    );
  }
}
