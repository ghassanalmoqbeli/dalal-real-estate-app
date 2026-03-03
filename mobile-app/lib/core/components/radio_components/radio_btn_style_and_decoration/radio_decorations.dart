import 'package:flutter/material.dart';

class RBDeco {
  static BoxDecoration rActive(Color color, {Color? bgCol}) => BoxDecoration(
    color: bgCol ?? const Color(0xffE6F7F0),
    border: Border.all(color: color, width: 2),
    borderRadius: BorderRadius.circular(8),
  );

  static BoxDecoration rInActive(Color? color) => BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: color ?? Colors.grey.shade300, width: 2),
    borderRadius: BorderRadius.circular(8),
  );

  static WidgetStateProperty<Color?>? fillClr(bool isSelected, Color color) =>
      WidgetStateProperty.all<Color>(isSelected ? color : Colors.grey);
}
