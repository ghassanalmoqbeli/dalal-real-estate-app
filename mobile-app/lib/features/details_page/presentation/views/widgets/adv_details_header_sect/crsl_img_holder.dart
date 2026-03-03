import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/details_image_carousel.dart';
import 'package:dallal_proj/core/widgets/cust_img_holder.dart';
import 'package:flutter/material.dart';

class CrslImgHolder extends StatelessWidget {
  const CrslImgHolder({
    super.key,
    required this.widget,
    required this.aspectRatio,
    required this.index,
  });

  final AdvDetailsImgCarousel widget;
  final double aspectRatio;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CustImgHolder(
        radius: 8,
        aspect: aspectRatio,
        img: widget.imagePaths?[index],
      ),
    );
  }
}
