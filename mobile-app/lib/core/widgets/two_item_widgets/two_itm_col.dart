import 'package:flutter/material.dart';

class TwoItmCol extends StatelessWidget {
  const TwoItmCol({
    super.key,
    this.mXAlign = MainAxisAlignment.start,
    required this.btmChild,
    required this.topChild,
    this.mXSize = MainAxisSize.max,
    this.cXAlign = CrossAxisAlignment.center,
  });
  final MainAxisAlignment mXAlign;
  final CrossAxisAlignment cXAlign;
  final MainAxisSize mXSize;
  final Widget topChild;
  final Widget btmChild;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mXSize,
      mainAxisAlignment: mXAlign,
      crossAxisAlignment: cXAlign,
      children: [topChild, btmChild],
    );
  }
}
