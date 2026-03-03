import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_likes_btn.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_more_btn.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_likes_btn_shimmer.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_font_styles_colorer.dart';
import 'package:dallal_proj/core/utils/assets_data.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/ico_holder_my_adv.dart';
import 'package:flutter/material.dart';

class PCardH {
  static List<Widget> normalBtns(
    ShowDetailsEntity detailsEntity,
    void Function()? onTapDetails,
    void Function()? onTapLikes,
    String? likes,
    bool isLiked,
    ValueNotifier<bool> isLikedNotifier, {
    required XBSize moreBtnSize,
    XBSize? likeBtnSize,
  }) => [
    CardMoreBtn(
      onTap: onTapDetails,
      btnSize: moreBtnSize,
      style: FsC.colStW(FStyles.s12wB),
    ),
    CardLikesBtn(
      btnSize: likeBtnSize ?? moreBtnSize,
      // likesCount: detailsEntity.likes,
      onTap: onTapLikes,
      advListItem: detailsEntity,
      // isLiked: isLiked,
      // istLiked: isLikedNotifier,
    ),
  ];
  static List<Widget> normalBtnsShimmer(
    // ShowDetailsEntity detailsEntity,
    // void Function()? onTapDetails,
    // void Function()? onTapLikes,
    String? likes,
    bool isLiked, {
    // ValueNotifier<bool> isLikedNotifier, {
    required XBSize moreBtnSize,
    XBSize? likeBtnSize,
  }) => [
    CardMoreBtn(
      // onTap: onTapDetails,
      btnSize: moreBtnSize,
      style: FsC.colStW(FStyles.s12wB),
    ),
    CardLikesBtnShimmer(
      btnSize: likeBtnSize ?? moreBtnSize,
      likesCount: likes ?? '0',
      // onTap: onTapLikes,
      isLiked: isLiked,
      // isLikedNotifier: isLikedNotifier,
    ),
  ];

  static List<Widget> normalAdvBtns(
    void Function()? onTapDetails,
    void Function()? onTapDelete,
    void Function()? onTapEdit,
  ) => [
    const Spacer(flex: 1),
    CardMoreBtn(
      onTap: onTapDetails,
      btnSize: const XBSize(width: 71, height: 29),
      style: FsC.colStW(FStyles.s12wB),
    ),
    const Spacer(flex: 3),
    IcoHolderMyAdv(img: AssetsData.trashFilled, onTap: onTapDelete),
    const Spacer(flex: 3),
    IcoHolderMyAdv(img: AssetsData.editFilled, onTap: onTapEdit),
    const Spacer(flex: 1),
  ];
  static List<Widget> normalAdvBtnsShimmer(
    // void Function()? onTapDetails,
    // void Function()? onTapDelete,
    // void Function()? onTapEdit,
  ) => [
    const Spacer(flex: 1),
    CardMoreBtn(
      // onTap: onTapDetails,
      btnSize: const XBSize(width: 71, height: 29),
      style: FsC.colStW(FStyles.s12wB),
    ),
    const Spacer(flex: 3),
    const IcoHolderMyAdv(img: AssetsData.trashFilled), // onTap: onTapDelete),
    const Spacer(flex: 3),
    const IcoHolderMyAdv(img: AssetsData.editFilled), // onTap: onTapEdit),
    const Spacer(flex: 1),
  ];

  static EdgeInsetsGeometry hItemPadding() {
    return const EdgeInsets.only(left: 6.66, right: 5.66, top: 5, bottom: 2);
  }

  static EdgeInsetsGeometry vItemPadding() {
    return const EdgeInsets.all(7);
  }
}
