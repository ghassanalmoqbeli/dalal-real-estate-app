import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class PagePadding extends StatelessWidget {
  const PagePadding({super.key, required this.child, this.fract = 0.1});
  final Widget child;
  final double fract;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Funcs.respWidth(fract: fract, context: context),
      ),
      child: child,
    );
  }
}
