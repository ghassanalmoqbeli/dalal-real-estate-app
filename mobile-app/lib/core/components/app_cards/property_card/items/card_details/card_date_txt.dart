import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardDateTxt extends StatelessWidget {
  const CardDateTxt({
    this.fSize,
    super.key,
    required this.date,
    this.leftpadding = true,
    this.fHeight,
  });
  final DateTime date;
  final double? fSize, fHeight;
  final bool? leftpadding;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leftpadding!) const SizedBox(width: 5),
        Text(
          DateFormat(kDefDateFormat).format(date).toString(),
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: fSize ?? 8, height: fHeight ?? 0.5),
        ),
      ],
    );
  }
}
