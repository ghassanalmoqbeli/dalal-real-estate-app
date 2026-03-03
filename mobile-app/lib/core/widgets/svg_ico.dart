import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIco extends StatelessWidget {
  final String ico;
  final double? wth;
  final double? ht;
  final Color? color;
  final double? padding;

  const SvgIco({
    required this.ico,
    this.wth,
    this.ht,
    this.color,
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 0),
      child: SvgPicture.asset(
        ico,
        width: wth,
        height: ht,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
