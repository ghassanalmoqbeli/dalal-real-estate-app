import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:flutter/material.dart';

class SvgBtn extends StatelessWidget {
  const SvgBtn({
    super.key,
    required this.svg,
    this.onPressed,
    this.ht,
    this.wth,
    this.color,
    this.padding,
  });
  final String svg;
  final double? ht, wth;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      onPressed: onPressed,
      icon: SvgIco(ico: svg, ht: ht ?? 28, wth: wth ?? 28, color: color),
    );
  }
}
