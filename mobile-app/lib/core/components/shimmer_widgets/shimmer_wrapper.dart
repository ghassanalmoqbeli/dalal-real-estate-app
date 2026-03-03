import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({super.key, required this.child, this.isWaving = true});
  final Widget child;
  final bool isWaving;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.green.shade300,
      // baseColor: Colors.grey.shade300,
      highlightColor:
          (isWaving) ? Colors.green.shade100 : Colors.green.shade300,
      // highlightColor: Colors.grey.shade100,
      child: Opacity(opacity: 0.2, child: child),
    );
  }
}
