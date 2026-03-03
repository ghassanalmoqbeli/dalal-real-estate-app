import 'package:dallal_proj/core/widgets/cust_seperator.dart';
import 'package:flutter/material.dart';

class SeperatedBtnsBox extends StatelessWidget {
  const SeperatedBtnsBox({
    super.key,
    required this.children,
    this.sepWidth,
    this.rMXAlign,
  });
  final double? sepWidth;
  final List<Widget> children;
  final MainAxisAlignment? rMXAlign;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustSeperator(width: sepWidth),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: rMXAlign ?? MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ],
    );
  }
}
