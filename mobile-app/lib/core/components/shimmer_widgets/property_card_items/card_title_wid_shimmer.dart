import 'package:dallal_proj/core/components/shimmer_widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';

class CardTitleWidShimmer extends StatelessWidget {
  const CardTitleWidShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .35,
        height: 13,
        child: Container(color: Colors.green[100]),
      ),
    );
    // );
  }
}
