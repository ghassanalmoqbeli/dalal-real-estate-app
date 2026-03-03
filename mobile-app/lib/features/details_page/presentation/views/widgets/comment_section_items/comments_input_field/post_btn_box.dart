import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_shadows.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:flutter/material.dart';

class PostBtnBox extends StatelessWidget {
  const PostBtnBox({super.key, required this.child, this.onTap});
  final Widget child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 53,
        margin: const EdgeInsets.all(8),
        decoration: Themer.genShape(color: kPrimColG, shadows: [Shads.shadow8]),
        child: AspectRatio(
          aspectRatio: 55 / 33,
          child: Column(children: [Expanded(child: child)]),
        ),
      ),
    );
  }
}
