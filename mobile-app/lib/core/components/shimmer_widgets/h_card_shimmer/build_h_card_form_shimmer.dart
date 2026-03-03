import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_date_txt_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_property_image_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_title_wid_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/right_ico_line_shimmer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:flutter/material.dart';

List<Widget> buildHCardFormShimmer({
  bool? isFaved = false,
  bool? isFeatured = false,
  bool? status,
  required Widget child,
}) {
  return [
    CardPropertyImageShimmer(
      isFaved: isFaved,
      isFeatured: isFeatured,
      status: status,
    ),
    const Spacer(flex: 2),
    const CardDateTxtShimmer(),
    const Spacer(flex: 4),
    const CardTitleWidShimmer(),
    const Spacer(flex: 6),
    const RightIcoLineShimmer(
      // text: advsListItem.adress!,
      icoPath: AssetsData.locationSvg,

      // style: FStyles.s10w5h1o6,
    ),
    const Spacer(flex: 1),
    const RightIcoLineShimmer(
      // text: advsListItem.section!,
      icoPath: AssetsData.buildingSvg,
      // style: FStyles.s10w5h1o6,
    ),
    const Spacer(flex: 1),
    const RightIcoLineShimmer(
      // text: advsListItem.price!,
      icoPath: AssetsData.tagSvg,
      // style: FStyles.s10w5h1o6,
    ),
    const Spacer(flex: 6),
    child,
  ];
}
