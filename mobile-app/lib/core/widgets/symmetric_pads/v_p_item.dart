import 'package:flutter/material.dart';

class VPItem extends StatelessWidget {
  const VPItem({
    super.key,
    required this.child,
    this.bSpc = 0,
    this.tSpc = 0,
    this.mXSize = MainAxisSize.min,
    this.cXAlign = CrossAxisAlignment.center,
  });

  final Widget child;
  final double bSpc, tSpc;
  final MainAxisSize mXSize;
  final CrossAxisAlignment cXAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mXSize,
      crossAxisAlignment: cXAlign,
      children: [SizedBox(height: tSpc), child, SizedBox(height: bSpc)],
    );
  }
}
