import 'package:flutter/material.dart';

class TwoItmRow extends StatelessWidget {
  const TwoItmRow({
    super.key,
    this.mXAlign = MainAxisAlignment.spaceBetween,
    required this.leftChild,
    required this.rightChild,
    this.mXSize = MainAxisSize.max,
  });
  final MainAxisAlignment mXAlign;
  final MainAxisSize mXSize;
  final Widget leftChild;
  final Widget rightChild;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mXSize,
      mainAxisAlignment: mXAlign,
      children: [leftChild, rightChild],
    );
  }
}
