import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IVIco extends StatelessWidget {
  const IVIco({
    super.key,
    required this.isActv,
    required this.ico,
    required this.icoActv,
    this.icoWidth,
    this.icoHeight,
  });
  final bool isActv;
  final String ico, icoActv;
  final double? icoWidth, icoHeight;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isActv ? icoActv : ico,
      height: icoHeight ?? 20,
      width: icoWidth ?? 20,
    );
  }
}
