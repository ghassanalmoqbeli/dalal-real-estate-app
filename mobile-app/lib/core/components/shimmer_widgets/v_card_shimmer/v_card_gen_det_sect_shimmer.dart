import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_date_txt_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_seperated_btns_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_title_wid_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/right_ico_line_shimmer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:flutter/material.dart';

class VCardGenDetSectShimmer extends StatelessWidget {
  const VCardGenDetSectShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CardDateTxtShimmer(),
        Spacer(flex: 3),
        CardTitleWidShimmer(),
        Spacer(flex: 3),
        RightIcoLineShimmer(icoPath: AssetsData.locationSvg),
        VPItem(
          tSpc: 3,
          bSpc: 3,
          child: RightIcoLineShimmer(icoPath: AssetsData.buildingSvg),
        ),
        RightIcoLineShimmer(icoPath: AssetsData.tagSvg),
        Spacer(flex: 2),
        CardSeperatedBtnsShimmer(
          moreBtnSize: XBSize(width: 83.5429, height: 29),
          sepWidth: 177,
          isLiked: false,
        ),
      ],
    );
  }
}
