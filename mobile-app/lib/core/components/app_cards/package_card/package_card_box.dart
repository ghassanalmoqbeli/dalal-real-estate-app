import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_shadows.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class PckgCardBox extends StatelessWidget {
  const PckgCardBox({
    super.key,
    required this.cWidth,
    required this.child,
    this.onTap,
    required this.padding,
  });
  final Widget child;
  final double cWidth;
  final double padding;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 225,
        width: cWidth,
        padding: EdgeInsets.all(padding),
        decoration: Themer.genShape(
          color: kWhiteT6,
          rad: 12,
          shadows: [Shads.shadow4],
        ),
        child: child,
      ),
    );
  }
}
