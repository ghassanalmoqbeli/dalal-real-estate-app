import 'package:dallal_proj/core/components/shimmer_widgets/h_card_shimmer/h_card_item_shimmer.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class HCardListShimmer extends StatelessWidget {
  const HCardListShimmer({super.key}); // required this.advsList});
  // final List<ShowDetailsEntity> advsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Funcs.respHieght(fract: 0.39, context: context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(
              left: 6.66,
              right: 6.66,
              top: 1,
              bottom: 1,
            ),
            child: HCardItemShimmer(isPrem: true, status: true),
          );
        },
      ),
    );
  }
}
