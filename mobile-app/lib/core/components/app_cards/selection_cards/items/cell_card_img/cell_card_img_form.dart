import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CellCardImgForm extends StatelessWidget {
  const CellCardImgForm({
    super.key,
    required this.aspectRatio,
    required this.svgPath,
    this.label,
  });

  final double? aspectRatio;
  final String svgPath;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: aspectRatio ?? 1,
          child: SvgPicture.asset(svgPath),
        ),
        if (label != null)
          Positioned(
            bottom: -4,
            right: 3,
            child: Text(label!, style: FStyles.s16w6h175),
          ),
      ],
    );
  }
}
