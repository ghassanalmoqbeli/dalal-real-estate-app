import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IcoHolderMyAdv extends StatelessWidget {
  const IcoHolderMyAdv({super.key, required this.img, this.onTap});
  final String img;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(img, height: 24, width: 24),
    );
  }
}
