import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class NumericFieldBox extends StatelessWidget {
  const NumericFieldBox({
    super.key,
    required this.leftPadding,
    required this.rightPadding,
    required this.aspect,
    required this.child,
  });
  final double aspect;
  final Widget child;
  final double leftPadding, rightPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: leftPadding, right: rightPadding),
      decoration: Themer.numFieldCont(),
      child: AspectRatio(aspectRatio: aspect, child: child),
    );
  }
}
