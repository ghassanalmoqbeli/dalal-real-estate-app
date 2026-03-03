import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class BoxHolder extends StatelessWidget {
  const BoxHolder({
    super.key,
    required this.aspect,
    required this.children,
    required this.fixedSizeFraction,
  });
  final double aspect, fixedSizeFraction; //container const height
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Funcs.respHieght(fract: fixedSizeFraction, context: context),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(11.0),
      ),
      child: AspectRatio(
        aspectRatio: aspect,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: children,
        ),
      ),
    );
  }
}
