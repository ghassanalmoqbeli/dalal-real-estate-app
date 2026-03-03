import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/widgets/cust_img_holder.dart';
import 'package:dallal_proj/core/widgets/text_widgets/a_text.dart';
import 'package:dallal_proj/features/home_page/domain/entities/banner_entity.dart';
import 'package:flutter/material.dart';

class AdvItem extends StatelessWidget {
  const AdvItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Funcs.respWidth(fract: 0.16, context: context),
      width: Funcs.respWidth(fract: 0.85, context: context),
      decoration: BoxDecoration(
        color: kDSTeal,
        borderRadius: BorderRadius.circular(12),
      ),
      child: AText(txt: kPdMotionAd, style: FsC.colStW(FStyles.s20w6)),
    );
  }
}

class AdvItemViewer extends StatelessWidget {
  const AdvItemViewer({super.key, required this.banner, this.onTapBanner});
  final BannerEntity banner;
  final void Function()? onTapBanner;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBanner,
      child: CustImgHolder(
        img: (banner.bannerImg?.isNotEmpty ?? false) ? banner.bannerImg : null,
        radius: 12,
        // align: Alignment.bottomCenter,
        aspect:
            Funcs.respWidth(fract: 0.85, context: context) /
            Funcs.respWidth(fract: 0.16, context: context),
      ),
    );
  }
}
