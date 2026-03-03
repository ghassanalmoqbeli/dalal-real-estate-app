import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/card_seperated_btns_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/property_card_items/my_adv_seperated_btns_shimmer.dart';
import 'package:flutter/material.dart';

class HCardBtnSwitcherShimmer extends StatelessWidget {
  const HCardBtnSwitcherShimmer({
    super.key,
    // required this.detailsEntity,
    this.likes,
    this.isMine = false,
    required this.isLiked,
  });
  // final ShowDetailsEntity detailsEntity;
  final bool isMine;
  final bool isLiked;
  final String? likes;
  @override
  Widget build(BuildContext context) {
    return isMine
        ? const MyAdvSeperatedBtnsShimmer()
        : CardSeperatedBtnsShimmer(
          likes: likes,

          rMXAlign: MainAxisAlignment.spaceAround,
          moreBtnSize: const XBSize(width: 83.5429, height: 29),
          likeBtnSize: const XBSize(width: 83, height: 29),
          // detailsEntity: detailsEntity,
          // onTapDetails: () => Funcs.pushToAdv(context, detailsEntity),
          // onTapLikes: () {},
          isLiked: isLiked,
        );
  }
}
