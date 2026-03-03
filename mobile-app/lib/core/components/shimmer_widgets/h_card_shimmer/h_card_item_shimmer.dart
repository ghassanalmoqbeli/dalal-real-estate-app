import 'package:dallal_proj/core/components/app_cards/property_card/h_card/h_card_box.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/h_card_shimmer/h_card_form_shimmer.dart';
import 'package:flutter/material.dart';

class HCardItemShimmer extends StatelessWidget {
  const HCardItemShimmer({
    super.key,
    // required this.advsListItem,
    this.isMyAdvScreen = false,
    this.isPrem = false,
    // this.isFeatured = false,
    this.isFaved = false,
    this.status = true,
  });
  // final ShowDetailsEntity advsListItem;
  final bool isMyAdvScreen, isPrem, isFaved;
  final bool? status;

  @override
  Widget build(BuildContext context) {
    return HCardBox(
      child: HCardFormShimmer(
        // advsListItem: advsListItem,
        // isLiked: ,
        // likes: advsListItem.likesCount,
        status: status,
        isFaved: isFaved,
        isFeatured: isPrem,
        isMine: isMyAdvScreen,
      ),
    );
  }
}
