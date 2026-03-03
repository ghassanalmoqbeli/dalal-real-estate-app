import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/details_image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmothPgInd extends StatelessWidget {
  const SmothPgInd({
    super.key,
    required PageController controller,
    required this.widget,
  }) : _controller = controller;

  final PageController _controller;
  final AdvDetailsImgCarousel widget;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      count: widget.imagePaths?.length ?? 1,
      effect: WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        spacing: 6,
        activeDotColor: kPrimColG,
        dotColor: kWhite.withValues(alpha: 0.40),
      ),
    );
  }
}
