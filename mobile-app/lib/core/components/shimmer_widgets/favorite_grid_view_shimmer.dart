import 'package:dallal_proj/core/components/shimmer_widgets/h_card_shimmer/h_card_item_shimmer.dart';
import 'package:dallal_proj/core/constants/wid_lists.dart';
import 'package:flutter/widgets.dart';

class FavoriteGridViewShimmer extends StatelessWidget {
  const FavoriteGridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.only(top: 30, bottom: 30, right: 2, left: 2),
      gridDelegate: CLwid.kGridDelegate(context),
      itemBuilder: (context, index) {
        return const HCardItemShimmer();
      },
    );
  }
}
