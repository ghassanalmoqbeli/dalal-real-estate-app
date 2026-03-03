import 'package:dallal_proj/core/components/app_cards/property_card/items/property_card_helper.dart';
import 'package:dallal_proj/core/components/app_cards/property_card/items/card_btns/card_seperated_btns_box.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:flutter/material.dart';

class CardSeperatedBtns extends StatelessWidget {
  const CardSeperatedBtns({
    super.key,
    this.sepWidth,
    this.onTapDetails,
    this.onTapLikes,
    required this.detailsEntity,
    this.likeBtnSize,
    required this.moreBtnSize,
    required this.isLikedNotifier,
    this.rMXAlign,
  });

  final ValueNotifier<bool> isLikedNotifier;

  final ShowDetailsEntity detailsEntity;
  final void Function()? onTapLikes, onTapDetails;
  final double? sepWidth;
  final XBSize? likeBtnSize;
  final XBSize moreBtnSize;
  final MainAxisAlignment? rMXAlign;

  @override
  Widget build(BuildContext context) {
    return SeperatedBtnsBox(
      rMXAlign: rMXAlign,
      children: PCardH.normalBtns(
        detailsEntity,
        onTapDetails,
        onTapLikes,
        detailsEntity.likes,
        detailsEntity.isLiked,
        isLikedNotifier,
        moreBtnSize: moreBtnSize,
        likeBtnSize: likeBtnSize,
      ),
    );
  }
}
