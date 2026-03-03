import 'package:flutter/material.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:dallal_proj/core/widgets/svg_ico.dart';

class MoreTailBtn extends StatelessWidget {
  const MoreTailBtn({
    super.key,
    required this.onTap,
    required this.svgModel,
    required this.textWidget,
  });

  final void Function()? onTap;
  final SvgModel svgModel;
  final Widget textWidget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgIco(ico: svgModel.img, ht: svgModel.height, wth: svgModel.width),
          const Spacer(flex: 15),
          textWidget,
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
