import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';
import 'package:flutter/material.dart';

class IcoOnlyBtn extends StatelessWidget {
  const IcoOnlyBtn({
    super.key,
    this.onTap,
    this.aspect = 73 / 44,
    this.width,
    this.fillCol,
    this.color,
    required this.img,
    this.height,
    this.icoFractSize,
    this.isDef = false,
  });
  final bool isDef;
  final Color? fillCol, color;
  final String img;
  final double aspect;
  final double? width, height, icoFractSize;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height ?? 44,
        child: AspectRatio(
          aspectRatio: aspect,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: icoFractSize ?? 8),
            decoration: Themer.bard(fillCol ?? kPrimColG),
            child: SvgIco(ico: img, color: isDef ? null : color ?? kWhite),
          ),
        ),
      ),
    );
  }
}
