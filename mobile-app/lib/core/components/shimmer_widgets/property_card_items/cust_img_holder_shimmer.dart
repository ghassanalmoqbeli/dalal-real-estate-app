import 'package:dallal_proj/core/components/shimmer_widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';

class CustImgHolderShimmer extends StatelessWidget {
  const CustImgHolderShimmer({super.key, this.aspect, this.radius});
  final double? aspect, radius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
      child: AspectRatio(
        aspectRatio: aspect ?? 9 / 7,
        child: ShimmerWrapper(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
