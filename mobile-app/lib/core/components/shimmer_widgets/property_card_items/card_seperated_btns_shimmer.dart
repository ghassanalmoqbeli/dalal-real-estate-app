import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_seperated_btns_box.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/property_card_helper.dart';
import 'package:flutter/material.dart';

class CardSeperatedBtnsShimmer extends StatelessWidget {
  const CardSeperatedBtnsShimmer({
    super.key,
    this.sepWidth,
    // this.onTapDetails,
    // this.onTapLikes,
    // required this.detailsEntity,
    this.likes,
    this.likeBtnSize,
    required this.moreBtnSize,
    this.isLiked,
    this.rMXAlign,
  });

  final bool? isLiked;

  // final ShowDetailsEntity detailsEntity;
  // final void Function()? onTapLikes, onTapDetails;
  final String? likes;
  final double? sepWidth;
  final XBSize? likeBtnSize;
  final XBSize moreBtnSize;
  final MainAxisAlignment? rMXAlign;

  @override
  Widget build(BuildContext context) {
    return SeperatedBtnsBox(
      rMXAlign: rMXAlign,
      children: PCardH.normalBtnsShimmer(
        // detailsEntity,
        // onTapDetails,
        // onTapLikes,
        likes,
        isLiked ?? false,
        // isLikedNotifier,
        moreBtnSize: moreBtnSize,
        likeBtnSize: likeBtnSize,
      ),
    );
  }
}
