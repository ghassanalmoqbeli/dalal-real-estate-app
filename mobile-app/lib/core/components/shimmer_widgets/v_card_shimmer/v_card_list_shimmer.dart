import 'package:dallal_proj/core/components/shimmer_widgets/v_card_shimmer/v_card_item_shimmer.dart';
import 'package:flutter/material.dart';

class VCardListShimmer extends StatelessWidget {
  const VCardListShimmer({super.key});
  // final List<ShowDetailsEntity> detailsEntity;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder:
          (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            child: VCardItemShimmer(),
          ),
    );
  }
}
