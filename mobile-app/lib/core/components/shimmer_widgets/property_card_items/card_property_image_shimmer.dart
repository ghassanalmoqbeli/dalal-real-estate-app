import 'package:dallal_proj/core/components/app_cards/property_card/items/card_image/premium_label.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_image/psnd_svg_btn.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/cust_img_holder_shimmer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:flutter/material.dart';

class CardPropertyImageShimmer extends StatelessWidget {
  const CardPropertyImageShimmer({
    super.key,
    this.isFeatured = false,
    this.isFaved = false,
    this.status = true,
    this.aspect,
  });
  final bool? isFeatured, isFaved, status;
  final double? aspect;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustImgHolderShimmer(radius: 16, aspect: aspect),
        if (isFeatured ?? false)
          const Positioned(top: 9, left: 10, child: PremiumLabel()),
        if (status == true)
          PsndSvgBtn(
            svg:
                (isFaved ?? false)
                    ? AssetsData.filledHeartSvg
                    : AssetsData.heartSvg,
          ),
      ],
    );
  }
}
