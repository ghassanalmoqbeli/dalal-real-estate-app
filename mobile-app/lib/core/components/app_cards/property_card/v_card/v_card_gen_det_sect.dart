import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_details/card_date_txt.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_seperated_btns.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_details/card_title_wid.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_details/right_ico_line.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class VCardGenDetSect extends StatelessWidget {
  const VCardGenDetSect({
    super.key,
    required this.detailsEntity,
    required this.isLikedNotifier,
    this.onDetails,
    this.onLikes,
  });

  final ShowDetailsEntity detailsEntity;
  final ValueNotifier<bool> isLikedNotifier;
  final void Function()? onDetails, onLikes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CardDateTxt(date: WidH.str2date(detailsEntity.date!), fSize: 10),
        const Spacer(flex: 3),
        CardTitleWid(
          text: detailsEntity.titleDet,
          style: FsC.htStyle(FStyles.s14w6, 0.1),
        ),
        const Spacer(flex: 3),
        RightIcoLine(
          text: detailsEntity.adress ?? '',
          icoPath: AssetsData.locationSvg,
          style: FStyles.s12w5h1o6,
        ),
        VPItem(
          tSpc: 3,
          bSpc: 3,
          child: RightIcoLine(
            text: detailsEntity.sectionDet,
            icoPath: AssetsData.buildingSvg,
            style: FStyles.s12w5h1o6,
          ),
        ),
        RightIcoLine(
          text: detailsEntity.priceDet,
          icoPath: AssetsData.tagSvg,
          style: FStyles.s12w5h1o6,
        ),
        const Spacer(flex: 2),
        CardSeperatedBtns(
          moreBtnSize: const XBSize(width: 83.5429, height: 29),
          detailsEntity: detailsEntity,
          sepWidth: 177,
          onTapDetails: onDetails,
          onTapLikes: onLikes,
          isLikedNotifier: isLikedNotifier,
        ),
      ],
    );
  }
}
