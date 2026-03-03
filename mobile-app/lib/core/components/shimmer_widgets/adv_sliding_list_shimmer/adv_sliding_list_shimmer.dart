import 'package:carousel_slider/carousel_slider.dart';
import 'package:dallal_proj/core/components/shimmer_widgets/adv_sliding_list_shimmer/adv_item_viewer_shimmer.dart';
import 'package:flutter/widgets.dart';

class AdvSlidingListShimmer extends StatelessWidget {
  const AdvSlidingListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return const AdvItemViewerShimmer();
      },
      options: CarouselOptions(
        enlargeFactor: 0.4,
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {},
      ),
    );
  }
}
