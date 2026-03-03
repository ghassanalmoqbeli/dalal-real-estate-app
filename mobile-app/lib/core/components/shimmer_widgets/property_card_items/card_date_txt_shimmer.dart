import 'package:dallal_proj/core/components/shimmer_widgets/shimmer_wrapper.dart';
import 'package:flutter/material.dart';

class CardDateTxtShimmer extends StatelessWidget {
  const CardDateTxtShimmer({
    // this.fSize,
    super.key,
    // required this.date,
    this.leftpadding = true,
  });
  // final DateTime date;
  final bool? leftpadding;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leftpadding!) const SizedBox(width: 5),
        ShimmerWrapper(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .2,
            height: 5, //(fHeight ?? 0.5)*(fSize??8),
            child: Container(color: Colors.green[100]),
          ),
        ),
      ],
    );
  }
}
