import 'package:dallal_proj/core/components/shimmer_widgets/h_card_shimmer/build_h_card_form_shimmer.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/h_card_shimmer/h_card_btn_switcher_shimmer.dart';
import 'package:flutter/material.dart';

class HCardFormShimmer extends StatelessWidget {
  const HCardFormShimmer({
    super.key,
    this.likes,
    this.isFaved = false,
    this.isLiked,
    this.isFeatured,
    this.isMine = false,
    this.status,
  });
  // final ShowDetailsEntity advsListItem;
  // final NCardModel cardModel;
  final String? likes;
  final bool isMine;
  final bool? isLiked, isFaved, isFeatured, status;

  @override
  Widget build(BuildContext context) {
    // final ValueNotifier<bool> isLikedNotifier = ValueNotifier(
    //   advsListItem.isLiked,
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: buildHCardFormShimmer(
        // advsListItem,
        // cardModel,
        isFaved: isFaved,
        isFeatured: isFeatured,
        status: status,
        child: HCardBtnSwitcherShimmer(
          likes: likes,
          // detailsEntity: advsListItem,
          isMine: isMine,
          isLiked: isLiked ?? false,
        ),
      ),
    );
  }
}
