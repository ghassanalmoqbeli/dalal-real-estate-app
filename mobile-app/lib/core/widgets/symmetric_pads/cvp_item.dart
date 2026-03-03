import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class CvpItem extends StatelessWidget {
  const CvpItem({
    super.key,
    required this.child,
    this.bFract = 0.000000000001,
    this.tFract = 0.000000000001,
    this.mXSize = MainAxisSize.min,
    this.cXAlign = CrossAxisAlignment.center,
  });

  final Widget child;
  final double bFract, tFract;
  final MainAxisSize mXSize;
  final CrossAxisAlignment cXAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mXSize,
      crossAxisAlignment: cXAlign,
      children: [
        SizedBox(height: Funcs.respHieght(fract: tFract, context: context)),
        child,
        SizedBox(height: Funcs.respHieght(fract: bFract, context: context)),
      ],
      // [SizedBox(height: tSpc), child, SizedBox(height: bSpc)],
    );
  }
}
