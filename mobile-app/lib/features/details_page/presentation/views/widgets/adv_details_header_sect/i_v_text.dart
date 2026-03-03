import 'package:flutter/material.dart';

class IVText extends StatelessWidget {
  const IVText({
    super.key,
    required this.txt,
    required this.txtColor,
    required this.txtActvColor,
    required this.isActv,
    this.fontSize,
  });
  final String txt;
  final Color txtColor;
  final Color txtActvColor;
  final bool isActv;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        fontSize: fontSize ?? 14,
        fontWeight: isActv ? FontWeight.bold : FontWeight.w600,
        color: isActv ? txtActvColor : txtColor,
      ),
    );
  }
}
