import 'package:dallal_proj/core/components/app_btns/svg_btn.dart';
import 'package:flutter/material.dart';

class HomeAppBarIcon extends StatelessWidget {
  const HomeAppBarIcon({super.key, required this.ico, this.onPressed});
  final String ico;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SvgBtn(svg: ico, ht: 30, wth: 30, onPressed: onPressed);
  }
}
