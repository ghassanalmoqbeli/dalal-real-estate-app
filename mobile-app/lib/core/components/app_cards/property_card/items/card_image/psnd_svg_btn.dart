import 'package:dallal_proj/core/components/app_btns/svg_btn.dart';
import 'package:flutter/widgets.dart';

class PsndSvgBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String svg;

  const PsndSvgBtn({super.key, this.onPressed, required this.svg});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -3,
      right: -3,
      child: SvgBtn(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        svg: svg,
        ht: 33,
        wth: 33,
      ),
    );
  }
}
